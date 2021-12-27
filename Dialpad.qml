import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    GridLayout {
        rows: 5
        columns: 3
        columnSpacing: 4
        rowSpacing: 4
        anchors.centerIn: parent
        Text {
            id: dial_string
            Layout.columnSpan: 3
            text: ""
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.weight: Font.ExtraBold
            minimumPixelSize: 14
            fontSizeMode: Text.VerticalFit
            color: "green"
        }

        DialKey {
            id: key1
            label.text: "1"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "1"
                }
            }
        }
        DialKey {
            id: key2
            label.text: "2"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "2"
                }
            }
        }
        DialKey {
            id: key3
            label.text: "3"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "3"
                }
            }
        }
        DialKey {
            id: key4
            label.text: "4"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "4"
                }
            }
        }
        DialKey {
            id: key5
            label.text: "5"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "5"
                }
            }
        }
        DialKey {
            id: key6
            label.text: "6"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "6"
                }
            }
        }
        DialKey {
            id: key7
            label.text: "7"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "7"
                }
            }
        }
        DialKey {
            id: key8
            label.text: "8"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "8"
                }
            }
        }
        DialKey {
            id: key9
            label.text: "9"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "9"
                }
            }
        }
        DialKey {
            id: keyStar
            label.text: "*"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "*"
                }
            }
        }
        DialKey {
            id: key0
            label.text: "0"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "0"
                }
            }
        }
        DialKey {
            id: keyPound
            label.text: "#"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dial_string.text += "#"
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

