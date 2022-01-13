import QtQuick 2.12
import QtGraphicalEffects 1.12
import sunnygui 1.0

Rectangle {
    id : root
    anchors.fill : parent
    color : SunStyles.bluOysterCult
    property int startWidth : 266
    property int startHeight : 66
    property int endWidth : startWidth * 2
    property int endHeight : startHeight * 2
    property int startX : 0
    property int startY : 0
    property int endX : (width - endWidth) / 2
    property int endY : (height - endHeight) / 2
    property color startColor : "steelblue"
    property color endColor : SunStyles.sunshineYellow
    property int duration : 1000
    signal finished()
    states : [
        State {
            name : "init"
            PropertyChanges {
                target : logo
                x : startX
                y : startY
                sourceSize.width: startWidth
                sourceSize.height: startHeight
            }
            PropertyChanges {
                target : overlay
                color : startColor
            }
        },
        State {
            name : "end"
            PropertyChanges {
                target : logo
                x : endX
                y : endY
                sourceSize.width: endWidth
                sourceSize.height: endHeight
            }
            PropertyChanges {
                target : overlay
                color : endColor
            }
            PropertyChanges {
                target : root
                opacity : 0
            }
            StateChangeScript{
                name: "fScript"
                script: root.finished();
            }
        }
    ]
    state : "init"
    Image {
        id : logo
        source : "qrc:/boot_logo.svg"
        antialiasing : true
        x : root.startX
        y : root.startY
        sourceSize.width:startWidth
        sourceSize.height:startHeight
        transformOrigin: Item.Center
    }
    ColorOverlay {
        id : overlay
        anchors.fill : logo
        source : logo
        color : startColor
    }

    transitions : [Transition {
            from : "init"
            to : "end"
            SequentialAnimation{
            ParallelAnimation {
                NumberAnimation {
                    properties : "x,y,sourceSize.width,sourceSize.height"
                    duration : root.duration
                }
                ColorAnimation {
                    duration : root.duration
                }
            }
            OpacityAnimator
            {
                duration:2000
            }

            ScriptAction {
            scriptName:"fScript"
            }
            }
        }
    ]

    Timer {
        interval : 30;
        running : true;
        repeat : false
        onTriggered : {
            root.fn_startAni();
        }
    }

    Component.onCompleted : {
        root.state = "init";
    }
    function fn_startAni() {
        root.state = "end";
    }
}
