import QtQuick

// A floating, fully rounded group. Put PillItems inside it; they sit edge to edge, so
// there is no rounding between items, only at the two ends of the group.
Rectangle {
    id: root

    default property alias items: row.data

    implicitWidth: row.implicitWidth
    implicitHeight: Theme.pillHeight
    radius: height / 2
    color: Theme.background
    border.width: Theme.thickness / 2
    border.color: Theme.primary

    Row {
        id: row
        height: parent.height
    }
}
