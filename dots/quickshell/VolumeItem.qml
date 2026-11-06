import Quickshell.Services.Pipewire
import QtQuick

// Default output volume. Click toggles mute, scrolling changes the volume.
PillItem {
    id: root

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool muted: sink?.audio?.muted ?? true

    visible: !!sink
    icon: muted ? "" : volume < 0.34 ? "" : ""
    iconColor: muted ? Theme.secondary : Theme.primary
    label: Math.round(volume * 100) + "%"
    tooltip: sink?.description ?? ""

    // Audio properties are only valid while the node is bound.
    PwObjectTracker {
        objects: [root.sink]
    }

    onClicked: {
        if (sink?.audio)
            sink.audio.muted = !sink.audio.muted;
    }
    onScrolled: delta => {
        if (sink?.audio)
            sink.audio.volume = Math.max(0, Math.min(1, volume + (delta > 0 ? 0.05 : -0.05)));
    }
}
