import QtQuick
import QtQuick.Layouts

// One cell inside a Pill. Shows an optional icon glyph and text label, plus anything
// placed inside it. Draws a thin divider before itself unless it is the first cell.
Item {
    id: root

    property string icon: ""
    property string label: ""
    property color iconColor: Theme.primary
    property string tooltip: ""
    property bool interactive: true // hover highlight and pointer cursor
    property real padding: 12

    // Anything declared inside a PillItem goes after the icon and label.
    default property alias content: row.data
    readonly property bool hovered: mouse.containsMouse

    signal clicked(var event)
    signal scrolled(real delta)

    implicitWidth: row.implicitWidth + 2 * padding
    implicitHeight: Theme.pillHeight

    Rectangle {
        anchors.fill: parent
        anchors.margins: 5
        radius: height / 2
        color: Theme.primary
        opacity: root.interactive && root.hovered ? 0.14 : 0

        Behavior on opacity {
            NumberAnimation { duration: 120 }
        }
    }

    Rectangle {
        visible: root.x > 0
        anchors.verticalCenter: parent.verticalCenter
        width: Theme.thickness / 2
        height: parent.height - Theme.thickness
        color: Theme.primary
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 6

        Text {
            visible: root.icon !== ""
            text: root.icon
            color: root.iconColor
            font.family: Theme.iconFont
            font.pixelSize: Theme.iconSize
        }

        Text {
            visible: root.label !== ""
            text: root.label
            color: Theme.text
            font.pixelSize: Theme.fontSize
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: root.interactive ? Qt.PointingHandCursor : Qt.ArrowCursor
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        onClicked: event => root.clicked(event)
        onWheel: wheel => root.scrolled(wheel.angleDelta.y)
    }

    // Tooltip, drawn above the item. It lives in the same full-screen window, so it
    // needs no input region of its own.
    Rectangle {
        visible: opacity > 0
        opacity: root.tooltip !== "" && root.hovered ? 1 : 0
        z: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.top
        anchors.bottomMargin: 10
        width: tipText.implicitWidth + 20
        height: tipText.implicitHeight + 12
        radius: 8
        color: Theme.background
        border.width: Theme.thickness / 2
        border.color: Theme.primary

        Behavior on opacity {
            NumberAnimation { duration: 120 }
        }

        Text {
            id: tipText
            anchors.centerIn: parent
            text: root.tooltip
            color: Theme.text
            font.pixelSize: Theme.fontSize - 1
        }
    }
}
