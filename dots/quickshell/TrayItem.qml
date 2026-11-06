import Quickshell.Widgets
import QtQuick

// One status-notifier (tray) icon: Discord, Ulauncher, and so on.
// Left click activates, middle click is the secondary action, right click opens its menu.
PillItem {
    id: root

    required property var modelData // a SystemTrayItem
    required property var panel // the window the menu opens relative to

    padding: 9
    tooltip: modelData.tooltipTitle || modelData.title

    onClicked: event => {
        if (event.button === Qt.MiddleButton) {
            modelData.secondaryActivate();
        } else if (event.button === Qt.RightButton || modelData.onlyMenu) {
            if (modelData.hasMenu) {
                const p = root.mapToItem(null, 0, 0);
                modelData.display(panel, p.x, p.y);
            }
        } else {
            modelData.activate();
        }
    }

    IconImage {
        implicitSize: 18
        source: root.modelData.icon
    }
}
