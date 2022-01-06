import QtQuick 2.0
import QtQml 2.12
import QtQuick.Controls 2.12

Item {
    anchors.topMargin : 10
    property alias message:percent.text
    Column {
        anchors.fill : parent
        spacing : 20
        Rectangle {
            radius : 5
            color : "gray"
            height : 20
            width : parent.width
            opacity : .2
            ProgressBar {
                id : booty_pb
                width : parent.width * 0.8
                height : 30
                value : ProgressObj.current
                anchors.centerIn : parent
            }
        }
        Text {
            id : percent
            text : qsTr("Loading...")
            color : "white"
            width : parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment : Text.AlignHCenter
            height : 100
        }
    }


}
