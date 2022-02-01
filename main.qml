import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import sunnygui 1.0

ApplicationWindow {
    id : rootWindow
    width : 700
    height : 360
    visible : true
    color : "#000048"
    title : qsTr("Stack")

    header : ToolBar {
        id : header
        width : parent.width
        contentHeight : toolButton.implicitHeight
        // if you specify things in the "right" order they will "stack" as expected
        // i.e. first thing specified will be on the bottom.  Otherwise, you will
        // need to specify a z-value to get depth ordering correct.
        StatusBar {
            id : status_bar
        }
        ToolButton {
            id : toolButton
            text : "\u2630"
            font.pixelSize : Qt.application.font.pixelSize * 1.6
            hoverEnabled : false
            display : AbstractButton.TextOnly
            onClicked : {
                toggleDrawer()
            }
        }
    }


    /*
    Phoney {
        id: phoney
        visible: false
    }
    */
    function isPhoneLaunched() {
        if (loaderSid.item instanceof Phoney) {
            return true
        } else {
            return false
        }
    }
    function toggleDrawer() {
        var open = (drawer.position > 0.0)
        if (open) 
            drawer.close()
         else 
            drawer.open()


        


    }

    function closeDrawer() {
        drawer.close()
    }
    Drawer {
        id : drawer
        y : toolButton.height
        width : rootWindow.width * 0.30
        height : rootWindow.height - y
        property int btnCount : 7
        property int btnHeight : 35
        edge : Qt.LeftEdge

        //        modal: false
        //        Overlay.modal: Rectangle {
        //            color: "#ff000000"
        //        }
        Column {
            width : parent.width
            visible : true
            height : parent.height - drawer.btnHeight
            clip : true
            ItemDelegate {
                id : menu_dialpad
                width : parent.width
                height : drawer.btnHeight
                text : qsTr("Dialpad")
                icon.source : "qrc:/assets/icons/dialpad.svg"
                icon.color : "white"
                onClicked : {
                    if (! isPhoneLaunched()) {
                        closeDrawer()
                        return
                    }
                    loaderSid.item.visible = true;
                    loaderSid.item.stackPhoney.pop();
                    loaderSid.item.stackPhoney.push("qrc:/Dialpad.qml");
                    closeDrawer();
                }
            }
            Item {
                id : menu_activities
                width : parent.width
                height : item_height
                clip : true
                property bool collapsed : false
                property int sub_menu_height : 4 * item_height
                property int item_height : drawer.btnHeight
                property int margin_left : 10
                function toggleSubMenu() {
                    if (collapsed) {
                        height = item_height
                        sub.visible = false;
                    } else {
                        height = item_height + sub_menu_height;
                        sub.visible = true;
                    }
                    collapsed = !collapsed;
                }
                ItemDelegate {
                    id : btn_activity
                    width : parent.width
                    height : parent.item_height
                    text : qsTrId("Activities")
                    icon.source : "qrc:/assets/icons/expand.svg"
                    icon.color : "white"
                    onClicked : {
                        parent.toggleSubMenu();
                    }
                }

                Column {
                    id : sub
                    anchors.top : btn_activity.bottom
                    width : parent.width - parent.margin_left;
                    x : parent.margin_left;
                    height : parent.sub_menu_height;
                    visible : false;

                    ItemDelegate {
                        id : menu_item_0
                        width : parent.width
                        height : drawer.btnHeight

                        icon.source : "qrc:/assets/icons/shield.svg"
                        icon.color : "white"
                        text : qsTrId("SunScreen")
                        onClicked : {
                            if (! isPhoneLaunched()) {
                                closeDrawer()
                                return
                            }
                            loaderSid.item.visible = true;
                            loaderSid.item.stackPhoney.pop();
                            loaderSid.item.stackPhoney.push("qrc:/SunScreen.qml");
                            closeDrawer();
                        }
                    }
                    ItemDelegate {
                        id : menu_item_1
                        width : parent.width
                        height : drawer.btnHeight
                        icon.source : "qrc:/assets/icons/page.svg"
                        icon.color : "white"
                        text : qsTrId("Page 1")
                        onClicked : {
                            if (! isPhoneLaunched()) {
                                closeDrawer()
                                return
                            }
                            loaderSid.item.visible = true;
                            loaderSid.item.stackPhoney.pop();
                            loaderSid.item.stackPhoney.push("qrc:/Page1Form.qml");
                            closeDrawer();
                        }
                    }
                    ItemDelegate {
                        id : menu_item_2
                        width : parent.width
                        icon.source : "qrc:/assets/icons/favorite.svg"
                        icon.color : "white"
                        height : drawer.btnHeight
                        text : qsTrId("Favorite Girls")
                        onClicked : {
                            if (! isPhoneLaunched()) {
                                closeDrawer()
                                return
                            }
                            loaderSid.item.visible = true;
                            loaderSid.item.stackPhoney.pop();
                            loaderSid.item.stackPhoney.push("qrc:/Page2Form.qml");
                            closeDrawer();
                        }
                    }
                    ItemDelegate {
                        id : menu_item_3
                        width : parent.width
                        height : drawer.btnHeight
                        icon.source : "qrc:/assets/icons/elapsed.svg"
                        icon.color : "white"
                        text : qsTrId("Days Alive")
                        onClicked : {
                            if (! isPhoneLaunched()) {
                                closeDrawer()
                                return
                            }
                            loaderSid.item.visible = true;
                            console.log("pushing 'days of life' onto stackPhoney");
                            loaderSid.item.stackPhoney.pop();
                            loaderSid.item.stackPhoney.push("qrc:/DaysOfLife.qml");
                            closeDrawer();
                        }
                    }

                }
            }
        }
        ItemDelegate {
            id : footer
            width : parent.width
            height : drawer.btnHeight
            anchors.bottom : parent.bottom
            text : qsTrId("Exit")
            icon.source : "qrc:/assets/icons/exit.svg"
            icon.color : "white"
            onClicked : {
                rootWindow.close()
            }
        }
    }
    Loader {
        id : loaderSid
        anchors {
            left : parent.left
            right : parent.right
            top : header.bottom
            bottom : parent.bottom
        }
        source : "qrc:/Booty.qml"
        onLoaded : {
            console.debug("loaderSid.onLoaded(): source: [", source, "]");
            if (source == "qrc:/Phoney.qml") { // phoney.visible = true
                console.log("Booty");
                console.log(Booty);
                console.log("Phoney");
                console.log(Phoney);
                Booty.visible = false;
                console.log("phoney is visible");
            } else { // phoney.visible = false
                console.log("phoney is NOT visible");
            }
        }
    }
}
