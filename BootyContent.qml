import QtQuick 2.0
import QtQml 2.12
import QtQuick.Controls 2.12
import sunnygui 1.0

Rectangle {
    anchors.fill : parent
    Text {
        id : message
        x : parent.x + 8
        y : parent.height * .25
        width : parent.width - 16
        height : parent.height * .3
        color : SunStyles.sunshineYellow
        text : qsTr("app_name")
        font.pixelSize : height
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
        font.bold : true
        fontSizeMode : Text.Fit
    }
    BootProgressBar {
        id : pb
        anchors.top : message.bottom
        width : parent.width * 0.3
        height : parent.height * .2
        anchors.horizontalCenter : parent.horizontalCenter
        visible : false
    }
    Button {
        id : phone_launcher
        width : implicitWidth
        anchors {
            horizontalCenter : parent.horizontalCenter
            bottom : parent.bottom
            margins : 5
        }
        text : "Phone Launcher"
        onClicked : {
            ProgressObj.startJob();
            ProgressWriterObj.startJob();
            pb.visible = true;
            // loaderSid.source = "qrc:/Phoney.qml"
        }
    }

    ThreeCornerTouch {
        anchors {
            top : parent.top
            left : parent.left
            right : parent.right
            bottom : phone_launcher.top
        }
        title : qsTr("Go to phone launcher")
        testMode : false
        message : qsTr("Do you want to go to the Phone Launcher?")
        onAccepted : {
            loaderSid.source = "qrc:/Phoney.qml"
        }
    }

    Connections {
        target : ProgressObj
        onStatusChanged : function (new_status) {
            console.log("New status : " + new_status);
        }
        onCurrentChanged : function (new_value) {
            console.log("new progress : " + new_value)
            pb.message = "Loaded %" + parseInt(new_value * 100);
            if (new_value == 1.0) {
                loaderSid.source = "qrc:/Phoney.qml"
            }
        }
    }
}
