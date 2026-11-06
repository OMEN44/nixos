import QtQuick
import QtQuick.Shapes

// Draws the screen border as "full rectangle minus a hole". The hole is a rounded
// rectangle (innerRadius) with a bite taken out of its bottom edge: that bite is the
// notch. The notch has convex top corners and concave "flares" where it meets the
// border, so it looks like it grows out of the bottom border.
//
// Pure drawing, no Quickshell imports. Everything animates by changing
// notchWidth / notchHeight from the outside.
Shape {
    id: root

    property color color: "#05080D"
    property real thickness: 4
    property real innerRadius: 18

    property real notchWidth: 0
    property real notchHeight: 0
    property real notchCornerRadius: 14 // convex top corners of the notch
    property real notchFlareRadius: 14 // concave curves at the base of the notch

    // Clamped values so the path never degenerates while animating from/to zero.
    readonly property real nw: Math.max(0, notchWidth)
    readonly property real nh: Math.max(0, notchHeight)
    readonly property real rc: Math.max(0.01, Math.min(notchCornerRadius, nh / 2, nw / 2))
    readonly property real rf: Math.max(0.01, Math.min(notchFlareRadius, nh - rc))
    readonly property real r: Math.max(0.01, Math.min(innerRadius, (width - 2 * thickness) / 2, (height - 2 * thickness) / 2))

    // Hole bounds and notch centre line.
    readonly property real x0: thickness
    readonly property real y0: thickness
    readonly property real x1: width - thickness
    readonly property real y1: height - thickness
    readonly property real cx: width / 2

    preferredRendererType: Shape.CurveRenderer

    ShapePath {
        fillColor: "transparent"
        strokeColor: Theme.primary
        strokeWidth: 2

        // Outer rectangle, counter-clockwise on screen.
        startX: 0
        startY: 0
        // PathLine { x: 0; y: root.height }
        // PathLine { x: root.width; y: root.height }
        // PathLine { x: root.width; y: 0 }
        // PathLine { x: 0; y: 0 }

        // Hole, clockwise on screen (opposite winding, so it is cut out under
        // both fill rules).
        PathMove { x: root.x0 + root.r; y: root.y0 }

        // top edge -> top-right corner
        PathLine { x: root.x1 - root.r; y: root.y0 }
        PathArc { x: root.x1; y: root.y0 + root.r; radiusX: root.r; radiusY: root.r; direction: PathArc.Clockwise }

        // right edge -> bottom-right corner
        PathLine { x: root.x1; y: root.y1 - root.r }
        PathArc { x: root.x1 - root.r; y: root.y1; radiusX: root.r; radiusY: root.r; direction: PathArc.Clockwise }

        // bottom edge heading left -> flare up into the notch's right side
        PathLine { x: root.cx + root.nw / 2 + root.rf; y: root.y1 }
        PathArc { x: root.cx + root.nw / 2; y: root.y1 - root.rf; radiusX: root.rf; radiusY: root.rf; direction: PathArc.Clockwise }

        // notch right side -> top-right corner
        PathLine { x: root.cx + root.nw / 2; y: root.y1 - root.nh + root.rc }
        PathArc { x: root.cx + root.nw / 2 - root.rc; y: root.y1 - root.nh; radiusX: root.rc; radiusY: root.rc; direction: PathArc.Counterclockwise }

        // notch top -> top-left corner
        PathLine { x: root.cx - root.nw / 2 + root.rc; y: root.y1 - root.nh }
        PathArc { x: root.cx - root.nw / 2; y: root.y1 - root.nh + root.rc; radiusX: root.rc; radiusY: root.rc; direction: PathArc.Counterclockwise }

        // notch left side -> flare back out onto the bottom edge
        PathLine { x: root.cx - root.nw / 2; y: root.y1 - root.rf }
        PathArc { x: root.cx - root.nw / 2 - root.rf; y: root.y1; radiusX: root.rf; radiusY: root.rf; direction: PathArc.Clockwise }

        // bottom edge -> bottom-left corner
        PathLine { x: root.x0 + root.r; y: root.y1 }
        PathArc { x: root.x0; y: root.y1 - root.r; radiusX: root.r; radiusY: root.r; direction: PathArc.Clockwise }

        // left edge -> top-left corner (back to the start)
        PathLine { x: root.x0; y: root.y0 + root.r }
        PathArc { x: root.x0 + root.r; y: root.y0; radiusX: root.r; radiusY: root.r; direction: PathArc.Clockwise }
    }
}
