import QtQuick 2.12
import sunnygui 1.0
import "qrc:/forms/SunScreenForm.ui.qml" as SunScreenForm

Item {
    width: parent.width
    height: parent.height
    Rectangle {
        color: "red"
        width: parent.width
        height: parent.height
    }

    SunScreenForm {}
}
