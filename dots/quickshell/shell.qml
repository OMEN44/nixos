import Quickshell

// One ScreenFrame (border, notch and pills) per monitor.
ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: ScreenFrame {}
    }
}
