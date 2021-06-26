import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {
    id: item1
    anchors.fill: parent
    color: "#000048"
    border.color: "#e650bd"
    border.width: 8

    Text {
        id: phoney
        x: 280
        anchors.top: parent.top
        anchors.topMargin: 8
        color: "#808080"
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 20
        font.bold: true
        text: qsTr("phone stack")
    }

    property StackView stackPhoney: stackPhoney
    StackView {
        id: stackPhoney
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: phoney.bottom
        anchors.bottom: parent.bottom
        z: 1
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.bottomMargin: 8
        initialItem: DaysOfLife
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2}
}
##^##*/

