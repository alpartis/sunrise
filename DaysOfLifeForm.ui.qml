import QtQuick 2.4
import QtQuick.Controls 2.5

Page {
    anchors.fill: parent
    title: qsTr("Days of Our Lives")

    property alias label: label
    Label {
        id: label
        font.pointSize: 18
        anchors.centerIn: parent
        text: ("I have been alive for XXX days.")
    }
}

/*##^##
Designer {
    D{i:0;height:0;width:0}
}
##^##*/

