import QtQuick 2.12
import sunnygui 1.0
import forms 1.0

Item {
    SunScreenForm {
        signal flip_burger()    // declare the signal

        function drawer_toggle() {
            console.log("clicked in hamburger icon")
        }

        hamburger_icon {

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    flip_burger()   // fire the signal
                }
            }
        }
    }
    Component.onCompleted: {
        // connect signal(s) to slot(s)
        flip_burger.connect(drawer_toggle)
    }
}
