import QtQuick 2.0
import QtQuick.Controls 2.12

MultiPointTouchArea {
    id:tarea
    enabled: true
    minimumTouchPoints: 3
    property int touchWidth : width * 0.25
    property int touchHeight : height * 0.5
    property string message:qsTr("Do you want to launch the phone?")
    property string title:qsTr("Phone Launch?")
    property bool testMode:false
    signal accepted

    onPressed: function(list) {
        console.log("touching the area ... onPressed")

        var cornerList = [leftCorner,rightCorner,leftBottomCorner, rightBottomCorner];
        var hitCount = 0;
        for (var i in list) {
            for (var j=0; j<cornerList.length;j++) {
                var corner = cornerList[j];
                var tp = list[i]; //touch point
                var sceneX = tp.sceneX;
                var sceneY = tp.sceneY;
                var startX = tp.startX;
                var startY = tp.startY;
                var point = corner.mapFromItem(tarea,startX,startY);
                if (corner.contains(point)) {
                    hitCount++;
                    console.log("hit list :: hitCount:" + hitCount);
                    cornerList.splice(j,1);
                    break;
                }
            }
        }
        if (hitCount == minimumTouchPoints) {
            console.log("show dialog");
            var result = dialog.open();
        }

    }
    Component.onCompleted: {
        console.log("Area 51 engaged")
    }

    Rectangle {
        id:rightCorner
        width: tarea.touchWidth; height: tarea.touchHeight
        color: testMode?"green":"transparent"
        anchors.right: parent.right
        anchors.top: parent.top
    }

    Rectangle {
        id:leftCorner
        width: tarea.touchWidth; height: tarea.touchHeight
        color: testMode?"yellow":"transparent"
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Rectangle {
        id:leftBottomCorner
        width: tarea.touchWidth; height: tarea.touchHeight
        color: testMode?"blue":"transparent"
        anchors.left : parent.left;
        anchors.bottom: parent.bottom;
    }

    Rectangle {
        id:rightBottomCorner
        width: tarea.touchWidth; height: tarea.touchHeight
        color: testMode?"black":"transparent"
        anchors.right : parent.right;
        anchors.bottom: parent.bottom;
    }
    Dialog {
        id: dialog
        modal: true
        title: tarea.title
        standardButtons: Dialog.Ok|Dialog.Cancel
        anchors.centerIn: parent
        Label {
            text: tarea.message
        }   visible:false

        onAccepted:{
            tarea.accepted();
        }
    }
}