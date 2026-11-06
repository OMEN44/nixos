pragma Singleton

import Quickshell
import QtQuick

Singleton {
    // Same palette as dots/hyprland/hypr/contants.lua
    readonly property color background: "#05080D"
    readonly property color primary: "#87D2D7"
    readonly property color secondary: "#376372"
    readonly property color accent: "#EADF46"

    readonly property color text: "#E6EDF0"
    readonly property color warning: "#E06C75"

    readonly property int thickness: 4
    readonly property real pillHeight: 32
    readonly property int fontSize: 13
    readonly property int iconSize: 14
    readonly property string iconFont: "Symbols Nerd Font"
}
