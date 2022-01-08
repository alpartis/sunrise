import QtQuick 2.0
import QtQml 2.12
import QtQuick.Controls 2.12
import thundernet.general 1.0

Item {
    property alias message : percent.text
    Column {
        anchors.topMargin : 30
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
                objectName : "booty_pb"
                width : parent.width * 0.8
                height : 30
                value : ProgressObj.current
                anchors.centerIn : parent
            }
        }
        Rectangle {
            id: bg
            radius : 5
            color : "gray"
            height : 20
            width : parent.width
            opacity : .2
            ProgressBar {
                id : booty_pb_invoke
                objectName : "booty_pb_invoke"
                width : parent.width * 0.8
                height : 30
                value : 0
                anchors.centerIn : parent
                function invokeExample(alpha) {
                    alpha = parseFloat(alpha);
                    bg.opacity = alpha;
                }
            }
        }
        Text {
            id : percent
            text : qsTr("Loading...")
            color : "white"
            width : parent.width
            anchors.horizontalCenter : parent.horizontalCenter
            horizontalAlignment : Text.AlignHCenter
            height : 100
        }
    }


}
