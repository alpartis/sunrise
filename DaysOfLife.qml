import QtQuick 2.4
import QtQml 2.12
import QtQuick.Controls 2.12

Rectangle {
    //    anchors.fill: parent
    opacity: 1
    color: "cyan"
    border.color: "black"
    border.width: 5
    radius: 10


    Page {
        property int days_alive: 55.5 * 365.25

        anchors.fill: parent
        title: qsTr("Days of Our Lives")
        opacity: 1

        Label {
            id: label
            font.pointSize: 18
            anchors.centerIn: parent
            text: qsTr("I have been alive for %1 days").arg(
                      Number(days_alive).toLocaleString())
        }
    }
}
