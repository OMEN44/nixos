pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

// Power options with a confirm step. Clicking an action replaces the buttons with
// "<Action>?  ✓  ✕". Confirm runs it; cancel, or 5 seconds of nothing, goes back.
Pill {
    id: root

    property var pending: null // the action awaiting confirmation, or null

    readonly property var actions: [
        {
            icon: "",
            label: "Hibernate",
            command: ["systemctl", "hibernate"]
        },
        {
            icon: "",
            label: "Power off",
            command: ["systemctl", "poweroff"],
            danger: true
        },
        {
            icon: "",
            label: "Restart",
            command: ["systemctl", "reboot"]
        },
        {
            icon: "",
            label: "Log out",
            command: ["uwsm", "stop"]
        }
    ]

    // Normal state: one button per action.
    Repeater {
        model: root.actions

        delegate: PillItem {
            required property var modelData

            visible: root.pending === null
            icon: modelData.icon
            iconColor: modelData.danger ? Theme.warning : Theme.primary
            tooltip: modelData.label
            onClicked: root.pending = modelData
        }
    }

    // Confirming state.
    PillItem {
        visible: root.pending !== null
        interactive: false
        label: root.pending ? root.pending.label + "?" : ""
    }
    PillItem {
        visible: root.pending !== null
        icon: ""
        iconColor: Theme.warning
        tooltip: "Confirm"
        onClicked: {
            const command = root.pending.command;
            root.pending = null;
            Quickshell.execDetached(command);
        }
    }
    PillItem {
        visible: root.pending !== null
        icon: ""
        tooltip: "Cancel"
        onClicked: root.pending = null
    }

    Timer {
        running: root.pending !== null
        interval: 5000
        onTriggered: root.pending = null
    }
}
