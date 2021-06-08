import QtQuick 2.4
import QtQml 2.12

Rectangle {
    //    anchors.fill: parent
    opacity: 1
    color: "cyan"
    border.color: "black"
    border.width: 5
    radius: 10

    DaysOfLifeForm {
        property int days_alive: 55.5 * 365.25
        opacity: 1
        label {
            text: qsTr("I have been alive for %1 days").arg(
                      Number(days_alive).toLocaleString())
        }
    }
}
