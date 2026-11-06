import Quickshell
import Quickshell.Bluetooth
import QtQuick

// Bluetooth glyph and the number of connected devices. Hover lists them, click opens Blueman.
PillItem {
    id: root

    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property var devices: Bluetooth.devices.values.filter(d => d.connected)

    function describe(d) {
        return d.name + (d.batteryAvailable ? "  (" + Math.round(d.battery * 100) + "%)" : "");
    }

    visible: !!adapter
    icon: ""
    iconColor: adapter?.enabled ? Theme.primary : Theme.secondary
    label: String(devices.length)
    tooltip: !adapter?.enabled ? "Bluetooth is off" : devices.length === 0 ? "No devices connected" : devices.map(describe).join("\n")

    onClicked: Quickshell.execDetached(["blueman-manager"])
}
