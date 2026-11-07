pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick

// Row of icons, one per open window. Adding/removing a window fades and scales its
// icon, and the neighbours slide to make room.
ListView {
    id: root

    property real cell: 32 // size of one clickable slot
    property real iconSize: 22
    property color accent: "#87D2D7"

    // Hover state for the tooltip. The tooltip itself is drawn by ScreenFrame,
    // because this view clips everything outside its own box.
    property var hoveredEntry: null
    property string tipText: ""
    property real tipX: 0 // centre of the hovered icon, in this view's coordinates

    // Width needed to show every icon unclipped. The parent uses this to size the notch.
    readonly property real fullWidth: count > 0 ? count * cell + (count - 1) * spacing : 0

    orientation: ListView.Horizontal
    interactive: false
    clip: true
    spacing: 2
    height: cell

    model: ToplevelManager.toplevels

    delegate: Item {
        id: entry

        required property var modelData // a Toplevel

        readonly property string appId: modelData.appId
        readonly property var desktopEntry: DesktopEntries.heuristicLookup(appId)

        // This window's Hyprland object. A window on a special workspace is a minimised one.
        readonly property var hyprWindow: Hyprland.toplevels.values.find(t => t.wayland === modelData)
        readonly property bool minimised: hyprWindow?.workspace?.name.startsWith("special:") ?? false

        // Icon names to try, best first. The first one the icon theme really has wins.
        // iconPath(name, true) returns "" for a missing icon, instead of Qt's black and
        // magenta missing-texture image.
        readonly property var candidates: [
            desktopEntry?.icon ?? "",
            appId,
            appId.toLowerCase(),
            appId.split(".").pop().toLowerCase()
        ]
        readonly property string iconSource: {
            for (const name of candidates) {
                if (!name)
                    continue;
                if (name.startsWith("/"))
                    return "file://" + name; // some desktop entries use an absolute path
                const path = Quickshell.iconPath(name, true);
                if (path)
                    return path;
            }
            return "";
        }

        width: root.cell
        height: root.cell

        Component.onCompleted: {
            if (iconSource === "")
                console.warn("AppList: no icon found for appId '" + appId + "'");
        }

        Component.onDestruction: {
            if (root.hoveredEntry === entry)
                root.hoveredEntry = null;
        }

        Rectangle {
            anchors.fill: parent
            radius: 8
            color: root.accent
            opacity: entry.modelData.activated ? 0.28 : (mouse.containsMouse ? 0.14 : 0)

            Behavior on opacity {
                NumberAnimation { duration: 120 }
            }
        }

        IconImage {
            visible: entry.iconSource !== ""
            opacity: entry.minimised ? 0.45 : 1
            anchors.centerIn: parent
            implicitSize: root.iconSize
            source: entry.iconSource
        }

        // No icon in the theme: show a tile with the app's first letter instead.
        Rectangle {
            visible: entry.iconSource === ""
            anchors.centerIn: parent
            width: root.iconSize
            height: root.iconSize
            radius: 6
            color: root.accent

            Text {
                anchors.centerIn: parent
                text: (entry.appId || "?").charAt(0).toUpperCase()
                color: "#05080D"
                font.bold: true
                font.pixelSize: root.iconSize * 0.6
            }
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onContainsMouseChanged: {
                if (containsMouse) {
                    root.hoveredEntry = entry;
                    root.tipText = entry.modelData.title || entry.appId;
                    root.tipX = entry.x + entry.width / 2 - root.contentX;
                } else if (root.hoveredEntry === entry) {
                    root.hoveredEntry = null;
                }
            }
            onClicked: {
                if (entry.minimised)
                    // Restore just this window; activate() would open the whole special workspace.
                    Quickshell.execDetached(["hyprctl", "eval", 'minimise_restore_one("' + entry.hyprWindow.address + '")']);
                else
                    entry.modelData.activate();
            }
        }
    }

    add: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 220; easing.type: Easing.OutCubic }
            NumberAnimation { property: "scale"; from: 0.4; to: 1; duration: 220; easing.type: Easing.OutCubic }
        }
    }

    remove: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; to: 0; duration: 160; easing.type: Easing.OutCubic }
            NumberAnimation { property: "scale"; to: 0.4; duration: 160; easing.type: Easing.OutCubic }
        }
    }

    displaced: Transition {
        NumberAnimation { property: "x"; duration: 220; easing.type: Easing.OutCubic }
    }
}
