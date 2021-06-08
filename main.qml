import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: window
    width: 800
    height: 420
    visible: true
    color: "#000048"
    title: qsTr("Stack")

    property bool drawer_open: false

    header: ToolBar {
        id: header
        width: parent.width
        contentHeight: toolButton.implicitHeight
        // if you specify things in the "right" order they will "stack" as expected
        //  i.e. first thing specified will be on the bottom.  Otherwise, you will
        //  need to specify a z-value to get depth ordering correct.
        StatusBar {
            id: status_bar
        }
        ToolButton {
            id: toolButton
            text: "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            hoverEnabled: false
            display: AbstractButton.TextOnly
            onClicked: {
                if (drawer_open) {
                    drawer.close()
                    drawer_open = false
                } else {
                    drawer_open = true
                    drawer.open()
                }
            }
        }
    }
    Phoney {
        id: phoney
        visible: false
    }
    Drawer {
        id: drawer
        y: toolButton.height
        width: window.width * 0.30
        height: window.height - y
        edge: Qt.LeftEdge

        //        modal: false
        //        Overlay.modal: Rectangle {
        //            color: "#ff000000"
        //        }
        Column {
            width: parent.width
            ItemDelegate {
                id: menu_item_0
                width: parent.width
                anchors.top: parent.top
                text: "SunScreen"
                onClicked: {
                    phoney.visible = true
                    phoney.stackPhoney.pop()
                    drawer.close()
                    drawer_open = false
                }
            }
            ItemDelegate {
                id: menu_item_1
                width: parent.width
                anchors.top: menu_item_0.bottom
                text: qsTr("Page 1")
                onClicked: {
                    phoney.visible = true
                    phoney.stackPhoney.pop()
                    phoney.stackPhoney.push("qrc:/Page1Form.ui.qml")
                    drawer.close()
                    drawer_open = false
                }
            }
            ItemDelegate {
                id: menu_item_2
                width: parent.width
                anchors.top: menu_item_1.bottom
                text: qsTr("Page 2")
                onClicked: {
                    phoney.visible = true
                    phoney.stackPhoney.pop()
                    phoney.stackPhoney.push("qrc:/Page2Form.ui.qml")
                    drawer.close()
                    drawer_open = false
                }
            }
            ItemDelegate {
                id: menu_item_3
                width: parent.width
                anchors.top: menu_item_2.bottom
                text: qsTr("Days Alive")
                onClicked: {
                    phoney.visible = true
                    console.log("pushing 'days of life' onto stackPhoney")
                    phoney.stackPhoney.pop()
                    phoney.stackPhoney.push("qrc:/DaysOfLife.qml")
                    drawer.close()
                    drawer_open = false
                }
            }
        }
        ItemDelegate {
            id: footer
            width: parent.width
            anchors.bottom: parent.bottom
            text: "Exit"
            onClicked: {
                drawer_open = false
                window.close()
            }
        }
    }
    Loader {
        id: loaderSid
        anchors {
            left: parent.left
            right: parent.right
            top: header.bottom
            bottom: parent.bottom
        }
        source: "qrc:/Booty.qml"
        onLoaded: {
            console.debug("loaderSid.onLoaded(): source: [", source, "]")
            if (source == "qrc:/Phoney.qml") {
                phoney.visible = true
                console.log("phoney is visible")
            } else {
                phoney.visible = false
                console.log("phoney is NOT visible")
            }
        }
    }
}
