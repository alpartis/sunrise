import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    height: 50
    width: parent.width
    anchors {
        left: parent.left
        top: parent.top
    }
    color: "orange"

    Label {
        id: header_clock
        anchors {
            centerIn: parent
        }
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 36
        text: Qt.formatTime(new Date(), "h:mm AP")
    }
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