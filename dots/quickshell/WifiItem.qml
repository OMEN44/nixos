pragma ComponentBehavior: Bound

import Quickshell.Networking
import QtQuick

// Wi-Fi signal strength as four bars. Hover shows the network name. No click action yet.
PillItem {
    id: root

    readonly property var device: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    readonly property var network: device ? device.networks.values.find(n => n.connected) : undefined
    readonly property real strength: network ? network.signalStrength : 0
    readonly property int bars: network ? Math.max(1, Math.ceil(strength * 4)) : 0

    visible: device !== undefined
    interactive: false
    tooltip: network ? network.name + "  " + Math.round(strength * 100) + "%" : "Not connected"

    Row {
        spacing: 2

        Repeater {
            model: 4

            delegate: Item {
                id: bar

                required property int index

                width: 3
                height: 14

                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 4 + bar.index * 3
                    radius: 1
                    color: bar.index < root.bars ? Theme.primary : Theme.pillBorder
                }
            }
        }
    }
}
