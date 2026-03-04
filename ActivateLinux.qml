import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import QtQuick.Window
import Quickshell.Io

ShellRoot {
    PanelWindow {
        id: win
        screen: Quickshell.screens[0]   // :monitor 0
        WlrLayershell.layer: WlrLayer.Top  // :stacking "fg"
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        anchors {
            bottom: true
            right: true
        }

        width: 250
        margins.right: 8
        margins.bottom: 32
        color: "transparent"

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
