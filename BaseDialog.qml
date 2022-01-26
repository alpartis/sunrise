import QtQuick 2.0
import QtQuick.Controls 2.12
Popup {
    id : root
    width : appWindow.width
    height : appWindow.height
    modal : true
    property color styleBorderColor : "white"
    property int styleBorderSize : 2
    property int styleBorderRadius : 5

    topMargin : 0
    leftMargin : 0
    leftPadding : (appWindow.width - bodyWidth) / 2
    rightPadding : (appWindow.width - bodyWidth) / 2
    topPadding : (appWindow.height - bodyHeight) / 2
    bottomPadding : (appWindow.height - bodyHeight) / 2

    property string text : 'text'
    property string title : 'text'
    property int bodyWidth : 100
    property int bodyHeight : 75
    property variant buttons : [] // '0', '1']

    signal clicked(int index);
    background : Rectangle {
        id : bg
        width : root.width
        height : root.height
        color : "black"
        opacity : 0.8

    }
    contentItem : Rectangle {
        id : body
        color : "black"

        border.color : styleBorderColor
        border.width : styleBorderSize
        radius : styleBorderRadius

        MouseArea {
            anchors.fill : body
        }
        Text {
            id : title
            text : root.title
            color : "white"
            anchors {
                left : parent.left;
                top : parent.top;
                leftMargin : 0.03 * body.width
                topMargin : 5
            }
            font.pixelSize : 0.1 * body.height
            font.weight : Font.DemiBold
            width : 0.9 * parent.width
            wrapMode : Text.WordWrap
            horizontalAlignment : Text.AlignLeft

        }

        Text { // text
            id : message
            text : root.text
            color : "white"
            anchors {
                centerIn : parent;
                verticalCenterOffset : -0.1 * body.height
            }
            font.pixelSize : 0.1 * body.height
            width : 0.9 * body.width
            wrapMode : Text.WordWrap
            horizontalAlignment : Text.AlignHCenter
        }

        Row { // buttons
            id : row

            anchors {
                bottom : body.bottom;
                horizontalCenter : body.horizontalCenter;
                bottomMargin : 0.1 * body.height
            }
            spacing : 0.03 * body.width

            Repeater {
                id : repeater

                model : buttons

                delegate : Button {
                    width : Math.min(0.5 * body.width, (0.9 * body.width -(repeater.count - 1) * row.spacing) / repeater.count)
                    height : 0.25 * body.height
                    text : modelData
                    hoverEnabled : true

                    contentItem : Text {
                        text : parent.text
                        font : parent.font
                        color : parent.down ? "#17a81a" : "#21be2b"
                        horizontalAlignment : Text.AlignHCenter
                        verticalAlignment : Text.AlignVCenter
                        elide : Text.ElideRight
                    }

                    onClicked : root.clicked(index)
                    background : Rectangle {
                        width : Math.min(0.5 * body.width, (0.9 * body.width -(repeater.count - 1) * row.spacing) / repeater.count)
                        height : 0.2 * body.height
                        implicitWidth : 100
                        implicitHeight : 40
                        color : parent.hovered ? "#d6d6d6" : "#f6f6f6"
                        border.color : "#26282a"
                        border.width : 1
                        radius : 4
                    }


                }
            }
        }

    }
}
