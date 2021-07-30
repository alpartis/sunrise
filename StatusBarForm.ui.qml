import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: status_bar
    anchors {
        left: parent.left
        top: parent.top
    }
    color: "orange"

    property alias header_clock: header_clock
    Label {
        id: header_clock
        anchors {
            centerIn: parent
        }
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 36
        text: Qt.formatTime(new Date(), "h:mm AP")
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
