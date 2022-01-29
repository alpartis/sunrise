import QtQuick 2.4
import QtQml 2.12
import QtQuick.Controls 2.12

Rectangle {
    //    anchors.fill: parent
    color: "cyan"
    border.color: "black"
    border.width: 5
    radius: 10

    Page {
        id: days_page
        anchors.fill: parent
        title: qsTr("Days of Our Lives")

        Label {
            id: label
            font.pointSize: 18
            anchors.centerIn: parent
            text: qsTr("I have been alive for %1 days").arg(qbridge.daysAlive().toLocaleString())
        }
    }
}
