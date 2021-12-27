import QtQuick 2.12
import sunnygui 1.0

Item {
    Rectangle {
        id: sunScreenForm
        signal flip_burger()    // declare the signal

        anchors.fill: parent
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
            MouseArea {
                id: clickbaitHamburger
                anchors.fill: parent
                onClicked: {
                    sunScreenForm.flip_burger()
                }
            }
        }
    }
    Component.onCompleted: {
        // connect signal(s) to slot(s)
        sunScreenForm.flip_burger.connect(rootWindow.toggleDrawer)
    }
}