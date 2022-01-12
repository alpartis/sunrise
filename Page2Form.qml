import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml 2.12

Page {
    anchors.fill: parent
    title: qsTr("Page 2")
    Label {
        id: page_label
        text: qsTr("My All Time Favorite Girls")
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.bottomMargin: 16
        anchors.horizontalCenter: parent.horizontalCenter
    }
    ListModel {
        id: list_of_favorite_girls
        ListElement {
            first_name: "Amy"
            last_name: "Bredwell"
        }
        ListElement {
            first_name: "Ruby"
            last_name: "Sherwood"
        }
    }
    Component {
        id: girlLayout
        Item {
            width: girls_list.width; height: 40
            Text {
                anchors.fill: parent
                color: "#ffc0c0"
                horizontalAlignment: Text.AlignHCenter
                text: "<b>" + first_name + "</b>" + last_name
            }
        }
    }

    ListView {
        id: girls_list
        width: parent.width
        anchors {
            top: page_label.bottom
            topMargin: 16
            bottom: parent.bottom
        }
        model: list_of_favorite_girls
        delegate: girlLayout
    }
}
