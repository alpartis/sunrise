import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    id: days_of_life_page
    title: qsTr("Digium D80")

    padding: 10

    Image {
        anchors.fill: parent
        source: "https://cdn.sangoma.com/wp-content/uploads/D80-sangoma-1-768x644.png"
        fillMode: Image.PreserveAspectFit
    }
}
