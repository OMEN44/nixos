pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick

// The row of floating pills along the bottom, either side of the notch. Its height is
// the notch height, so everything here lines up with the app icons.
Item {
    id: root
    

    required property var panel // the PanelWindow, needed to open tray menus
    property real notchWidth: 0 // animated width of the notch
    property real notchGap: 22 // notch flare radius (14) plus some breathing room
    property real margin: 16 // distance from the screen edges

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    // Far left: time | date
    Pill {
        x: root.margin
        anchors.verticalCenter: parent.verticalCenter

        PillItem {
            interactive: false
            label: Qt.formatDateTime(clock.date, "HH:mm")
        }
        PillItem {
            interactive: false
            label: Qt.formatDateTime(clock.date, "ddd d MMM")
        }
    }

    // Left of the notch: bluetooth | battery | wifi | volume
    Pill {
        x: root.width / 2 - root.notchWidth / 2 - root.notchGap - width
        anchors.verticalCenter: parent.verticalCenter
        
        BluetoothItem {}
        BatteryItem {}
        WifiItem {}
        VolumeItem {}
    }

    // Right of the notch: background apps
    Pill {
        x: root.width / 2 + root.notchWidth / 2 + root.notchGap
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: SystemTray.items
            delegate: TrayItem {
                panel: root.panel
            }
        }

        // Launchers for tools that have no tray icon.
        PillItem {
            icon: ""
            tooltip: "Colour picker"
            onClicked: Quickshell.execDetached(["sh", "-c", 'color=$(hyprpicker -a) && wl-copy "$color"'])
        }
        PillItem {
            icon: ""
            tooltip: "Clipboard history"
            onClicked: Quickshell.execDetached(["cursor-clip"])
        }
    }

    // Far right: power options (with confirm)
    PowerPill {
        x: root.width - root.margin - width
        anchors.verticalCenter: parent.verticalCenter
    }
}
