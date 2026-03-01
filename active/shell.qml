import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

ShellRoot {

    // Kills the ActivateLinux overlay once activation succeeds
    Process {
        id: killOverlay
        command: ["pkill", "-f", "ActivateLinux"]
    }
    // ── Window ──────────────────────────────────────────────────────────────
    FloatingWindow {
        id: root
        width: 500
        height: 400
        title: "Linux Activation"
        visible: true

        // ── Gradient background ──────────────────────────────────────────────
        Rectangle {
            anchors.fill: parent

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#6c63ff" }
                GradientStop { position: 1.0; color: "#3f37c9" }
            }

            // ── Centred card ─────────────────────────────────────────────────
            Rectangle {
                id: card
                anchors.centerIn: parent
                width: 350
                height: cardColumn.implicitHeight + 80
                radius: 16
                color: Qt.rgba(1, 1, 1, 0.08)
                layer.enabled: true
                layer.effect: null   // backdrop-filter blur approximated via opacity

                // Soft drop-shadow via a slightly larger, blurred rectangle below
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -1
                    radius: parent.radius + 1
                    color: "transparent"
                    border.color: Qt.rgba(1, 1, 1, 0.12)
                    border.width: 1
                    z: -1
                }

                ColumnLayout {
                    id: cardColumn
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        margins: 40
                        topMargin: 40
                    }
                    spacing: 0

                    // ── Title ─────────────────────────────────────────────────
                    Text {
                        Layout.fillWidth: true
                        text: "Linux Activation"
                        color: "#ffffff"
                        font.pixelSize: 24
                        font.weight: Font.SemiBold
                        horizontalAlignment: Text.AlignHCenter
                        Layout.bottomMargin: 10
                    }

                    // ── Description ───────────────────────────────────────────
                    Text {
                        Layout.fillWidth: true
                        text: "Enter your activation key to enable local Linux services."
                        color: Qt.rgba(1, 1, 1, 0.9)
                        font.pixelSize: 14
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        Layout.bottomMargin: 25
                    }

                    // ── Key input ─────────────────────────────────────────────
                    TextField {
                        id: keyInput
                        Layout.fillWidth: true
                        placeholderText: "Activation Key"
                        font.pixelSize: 14
                        leftPadding: 12
                        rightPadding: 12
                        topPadding: 12
                        bottomPadding: 12
                        background: Rectangle {
                            radius: 8
                            color: "#ffffff"
                        }
                        Layout.bottomMargin: 15
                    }

                    // ── Activate button ───────────────────────────────────────
                    Rectangle {
                        id: activateBtn
                        Layout.fillWidth: true
                        height: 44
                        radius: 8
                        color: btnMouseArea.containsMouse ? "#e6e6ff" : "#ffffff"

                        Behavior on color { ColorAnimation { duration: 200 } }

                        Text {
                            anchors.centerIn: parent
                            text: "Activate"
                            color: "#3f37c9"
                            font.pixelSize: 14
                            font.weight: Font.SemiBold
                        }

                        MouseArea {
                            id: btnMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                const key = keyInput.text.trim()
                                if (key !== "") {
                                    successMsg.visible = true
                                    errorMsg.visible = false
                                    killOverlay.running = true  // hide the Activate Linux overlay
                                } else {
                                    errorMsg.visible = true
                                    successMsg.visible = false
                                }
                            }
                        }
                        Layout.bottomMargin: 0
                    }

                    // ── Success message ───────────────────────────────────────
                    Text {
                        id: successMsg
                        Layout.fillWidth: true
                        visible: false
                        text: "✔ Linux has been successfully activated."
                        color: "#d4ffd4"
                        font.pixelSize: 14
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        Layout.topMargin: 20
                    }

                    // ── Error message (replaces alert()) ──────────────────────
                    Text {
                        id: errorMsg
                        Layout.fillWidth: true
                        visible: false
                        text: "⚠ Please enter a valid activation key."
                        color: "#ffcccc"
                        font.pixelSize: 14
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        Layout.topMargin: 20
                    }
                }
            }
        }
    }
}
