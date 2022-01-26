import QtQuick 2.0
import QtQml 2.12
import QtQuick.Controls 2.12
import sunnygui 1.0

Rectangle {
    id : root
    anchors.fill : parent
    color : "green"
    Column {
        width : root.width
        height : root.height
        Text {
            id : message
            x : parent.x + 8
            width : parent.width - 16
            height : root.height * .3
            color : SunStyles.sunshineYellow
            text : qsTrId("app_name")
            font.pixelSize : height
            horizontalAlignment : Text.AlignHCenter
            verticalAlignment : Text.AlignVCenter
            font.bold : true
            fontSizeMode : Text.Fit
        }
        BootProgressBar {
            id : pb
            width : parent.width * 0.4
            height : root.height * .3
            anchors.horizontalCenter : parent.horizontalCenter
        }
        Item {
            width : parent.width
            height : root.height * 0.3
            Button {
                id : phone_launcher
                width : implicitWidth
                text : "Phone Launcher"
                anchors.horizontalCenter : parent.horizontalCenter
                anchors.bottom : parent.bottom
                onClicked : {
                    cdialog.open();
                }
            }
        }
    }

    BaseDialog {
        id : cdialog
        modal : true
        title : qsTr("Phone Launch?")
        buttons: QT_TR_NOOP(['No','Yes'])
        bodyWidth:  250
        bodyHeight: 150
        text : qsTr("Are you sure you want to launch the phone?")
        visible : false

        onClicked : function(index){
            if( index == 1) //index 1 is yes.
            {
                root.launchPhone();
            }
            this.close();
        }
    }


    function launchPhone() {
        ProgressObj.endJob();
        pb.visible = true;
        phone_launcher.enabled = false;
        loaderSid.source = "qrc:/Phoney.qml"
        cdialog.visible = false;
    }

    ThreeCornerTouch {
        anchors {
            top : parent.top
            left : parent.left
            right : parent.right
            bottom : phone_launcher.top
        }
        title : qsTr("Phone Launch?")
        testMode : false
        message : qsTr("Are you sure you want to launch the phone?")
        onAccepted : {
            launchPhone();
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
                launchPhone();
            }
        }
    }
}
