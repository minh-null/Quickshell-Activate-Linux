import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import QtQuick.Window
import Quickshell.Io
// Equivalent to the eww `activate-linux` window:
//   monitor 0, anchored bottom-right, 8px from right, 32px from bottom,
//   transparent background, always on top (stacking "fg")

ShellRoot {
    PanelWindow {
        id: win

        // ── Monitor / stacking ───────────────────────────────────────────────
        screen: Quickshell.screens[0]   // :monitor 0
        WlrLayershell.layer: WlrLayer.Top  // :stacking "fg"
        WlrLayershell.exclusionMode: ExclusionMode.Ignore

        // ── Anchoring – bottom right ─────────────────────────────────────────
        anchors {
            bottom: true
            right: true
        }

        // ── Geometry ─────────────────────────────────────────────────────────
        width: 250
        margins.right: 8
        margins.bottom: 32

        // ── Transparent window background ────────────────────────────────────
        color: "transparent"

        // ── Widget content ───────────────────────────────────────────────────
        ColumnLayout {
            id: content
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            spacing: 2

            // "Activate Linux"  (large)
            Text {
                text: "Activate Linux"
                color: Qt.rgba(250/255, 250/255, 250/255, 0.6)
                font.pixelSize: 18   // font_size="large" ≈ 18 px
                Layout.alignment: Qt.AlignLeft
            }

            // "Go to Settings to activate Linux"
            Text {
                text: "Go to Settings to activate Linux"
                color: Qt.rgba(250/255, 250/255, 250/255, 0.6)
                font.pixelSize: 13
                Layout.alignment: Qt.AlignLeft
            }

            // Invisible hit-area over the whole column (eventbox :onclick)
            MouseArea {
                anchors.fill: parent   // covers both Text items via ColumnLayout
                cursorShape: Qt.PointingHandCursor
                onClicked: proc.running = true

                Process {
                    id: proc
                    command: ["quickshell", "--path", "/home/minh_lol/.config/quickshell/active"]
                }
            }
        }
    }
}
