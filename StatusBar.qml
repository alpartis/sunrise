import QtQuick 2.4
import QtQuick.Controls 2.12

StatusBarForm {
    height: 50
    width: parent.width

    // @disable-check M300
    Timer {
        id: timer
        interval: 10000
        repeat: true
        running: true
        onTriggered: {
            //console.log("timer tick")
            header_clock.text = Qt.formatTime(new Date(), "h:mm AP")
        }
    }
}
