import QtQuick 2.12
//import "qrc:/forms"
import "../sunnygui/TestExternal.qml" as TestExternal


Item {
    width: parent.width
    height: parent.height
    Rectangle{
        color:"red"
        width:parent.width
        height:parent.height
    }

    TestExternal{

    }

/*
    SunScreen {
        anchors.fill: parent
    }
    */
}
