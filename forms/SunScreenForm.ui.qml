import QtQuick 2.12
import sunnygui 1.0

Rectangle {
    anchors.fill: parent
    property alias hamburger_icon: hamburger_icon
    color: SunStyles.bluOysterCult

    Text {
        text: qsTr("-< Sunny GUI >-")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        font.pointSize: 40
        anchors.centerIn: parent
        font.family: Constants.font.family
    }

    Image {
        id: hamburger_icon
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 8
        width: 48
        height: 38
        source: "../imports/ui_art_assets/hamburger.svg"
        sourceSize.height: 19
        sourceSize.width: 24
        fillMode: Image.PreserveAspectFit
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

