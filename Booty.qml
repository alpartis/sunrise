import QtQuick 2.0
import QtQuick.Controls 2.12
import sunnygui 1.0

Item {
    id: booty
    StartAnimation{
        id:ani
        x:0
        y:0
        anchors.fill : parent
        startX:0
        startY:0
        duration:5000
        onFinished: function(){
            booty.state = "launcher"
        }
    }

    BootyContent
    {
        id:content
        color:"transparent"
    }

    state:"animation"

    states:[
        State{
            name:"animation"
            PropertyChanges{
                target:ani
                visible:true
            }
            PropertyChanges{
                target:content
                visible:false
            }
        },
        State{
            name:"launcher"
            PropertyChanges{
                target:ani
                visible:true
            }
            PropertyChanges{
                target:content
                visible:true
            }
        }
    ]


}
