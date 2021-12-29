import QtQuick 2.0
import QtQuick.Controls 2.12
import sunnygui 1.0

Rectangle {
    anchors.fill : parent
    Text {
        id : message
        x : parent.x + 8
        y : parent.height * .25
        width : parent.width - 16
        height : parent.height * .5
        color : SunStyles.sunshineYellow
        text : qsTr("app_name")
        font.pixelSize : height
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
        font.bold : true
        fontSizeMode : Text.Fit
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
        onClicked : loaderSid.source = "qrc:/Phoney.qml"
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
}
