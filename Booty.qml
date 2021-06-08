import QtQuick 2.0
import QtQuick.Controls 2.12
import sunnygui 1.0

Item {
    id: booty
    anchors.fill: parent
    //    padding.bottom: 25
    Text {
        id: message
        x: parent.x + 8
        y: parent.height * .25
        width: parent.width - 16
        height: parent.height * .5
        color: SunStyles.sunshineYellow
        text: qsTr("sunrise")
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        fontSizeMode: Text.Fit
    }
    Button {
        id: phone_launcher
        width: implicitWidth
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            margins: 25
        }
        text: "Phone Launcher"
        onClicked: loaderSid.source = "qrc:/Phoney.qml"
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

