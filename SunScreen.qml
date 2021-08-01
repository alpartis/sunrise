import QtQuick 2.12
import sunnygui 1.0
import forms 1.0

Item {
    SunScreenForm {
        id: sunScreenForm
        signal flip_burger()    // declare the signal

        clickbaitHamburger.onClicked: {
            sunScreenForm.flip_burger()   // fire the signal
        }
    }
    Component.onCompleted: {
        // connect signal(s) to slot(s)
        sunScreenForm.flip_burger.connect(rootWindow.toggleDrawer)
    }
}
