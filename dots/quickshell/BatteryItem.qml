import Quickshell.Services.UPower
import QtQuick

// Battery as a progress bar with the percentage. Hidden on machines without a battery.
PillItem {
    id: root

    readonly property var device: UPower.displayDevice
    readonly property real level: Math.max(0, Math.min(1, device.percentage))
    readonly property bool charging: device.state === UPowerDeviceState.Charging || device.state === UPowerDeviceState.FullyCharged
    readonly property bool low: level <= 0.15 && !charging

    function duration(seconds) {
        const h = Math.floor(seconds / 3600);
        const m = Math.floor(seconds % 3600 / 60);
        return h > 0 ? h + "h " + m + "m" : m + "m";
    }

    visible: device.ready && device.isLaptopBattery
    interactive: false
    tooltip: {
        if (device.state === UPowerDeviceState.Charging)
            return "Charging";
        if (device.state === UPowerDeviceState.FullyCharged)
            return "Fully charged";
        if (device.state === UPowerDeviceState.Discharging && device.timeToEmpty > 0)
            return "Discharging\n" + duration(device.timeToEmpty) + " remaining";
        return "Battery";
    }

    Text {
        visible: root.charging
        text: ""
        color: Theme.accent
        font.family: Theme.iconFont
        font.pixelSize: Theme.iconSize
    }

    Rectangle {
        implicitWidth: 44
        implicitHeight: 8
        radius: 4
        color: Theme.pillBorder

        Rectangle {
            width: parent.width * root.level
            height: parent.height
            radius: 4
            color: root.low ? Theme.warning : Theme.primary

            Behavior on width {
                NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
            }
        }
    }

    Text {
        text: Math.round(root.level * 100) + "%"
        color: Theme.text
        font.pixelSize: Theme.fontSize
    }
}
