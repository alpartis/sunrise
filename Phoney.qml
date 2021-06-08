import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    anchors.fill: parent
    property StackView stackPhoney: stackPhoney
    StackView {
        id: stackPhoney
        anchors.fill: parent
        initialItem: "qrc:/forms/SunScreen"
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

