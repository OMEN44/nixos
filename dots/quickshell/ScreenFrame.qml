pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

// One instance per screen (see shell.qml). Provides:
//   1. a full-screen, click-through window that draws the border and the app notch
//   2. four tiny invisible windows that reserve the border thickness, so tiled and
//      maximised windows stay inside the border
Scope {
    id: root

    // Injected by Variants in shell.qml.
    required property var modelData

    property color frameColor: Theme.secondary
    property color accentColor: Theme.primary

    property real thickness: 4
    property real innerRadius: 8
    property bool showNotch: true

    property real notchPadX: 14
    property real notchPadY: 6
    property int animationMs: 280

    // Height of the bottom row. The notch fills it exactly and the pills are centred in it.
    readonly property real barHeight: appList.cell + 2 * notchPadY

    // Target size of the notch: zero when there is nothing to show.
    readonly property bool notchVisible: showNotch && appList.count > 0
    readonly property real targetWidth: notchVisible ? appList.fullWidth + 2 * notchPadX : 0
    readonly property real targetHeight: notchVisible ? barHeight : 0

    // The animated sizes. Both the drawn shape and the icon row follow these, so the
    // notch grows and shrinks smoothly as apps open and close.
    property real notchWidth: targetWidth
    property real notchHeight: targetHeight

    Behavior on notchWidth {
        NumberAnimation { duration: root.animationMs; easing.type: Easing.OutCubic }
    }
    Behavior on notchHeight {
        NumberAnimation { duration: root.animationMs; easing.type: Easing.OutCubic }
    }

    PanelWindow { // qmllint disable uncreatable-type
        id: win

        screen: root.modelData
        color: "transparent"

        // Cover the whole output even though the edge windows below reserve space.
        exclusionMode: ExclusionMode.Ignore
        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        // Only the bottom row (pills and notch) takes input; everything else falls
        // through to the windows below.
        mask: Region {
            item: bottomBar
        }

        FrameShape {
            anchors.fill: parent
            color: root.frameColor
            thickness: root.thickness
            innerRadius: root.innerRadius
            notchWidth: root.notchWidth
            notchHeight: root.notchHeight
        }

        BottomBar {
            id: bottomBar
            panel: win
            notchWidth: root.notchWidth
            width: win.width
            height: root.barHeight
            y: win.height - root.thickness - height
        }

        AppList {
            id: appList
            accent: root.accentColor
            width: Math.max(0, root.notchWidth - 2 * root.notchPadX)
            x: (win.width - width) / 2
            y: win.height - root.thickness - root.notchHeight / 2 - height / 2
        }
    }

    // Layer-shell only honours an exclusive zone for a window anchored to exactly one
    // edge (or three), so each edge gets its own 1x1 invisible window.
    component Reserve: PanelWindow { // qmllint disable uncreatable-type
        screen: root.modelData
        color: "transparent"
        implicitWidth: 1
        implicitHeight: 1
        exclusiveZone: root.thickness
        mask: Region {}
    }

    Reserve { anchors.top: true }
    Reserve { anchors.bottom: true; exclusiveZone: root.thickness + root.barHeight }
    Reserve { anchors.left: true }
    Reserve { anchors.right: true }
}
