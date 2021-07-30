import QtQuick 2.12

Item {
    id: root
    width: 50
    height: 50

    property alias label: label

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ff0808ee"
            }

            GradientStop {
                position: 1
                color: "#ff000000"
            }
        }
        radius: 25
        border.color: "#0570d7"
        Text {
            id: label
            anchors.centerIn: parent
            anchors.fill: parent
            text: "0"
            color: "white"
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
