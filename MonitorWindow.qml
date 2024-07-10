import QtQuick 2.15

Rectangle {
    // define background colors for light/dark mode
    property string lightBkg: "#FFFFFF"
    property string darkBkg: "#121212"

    color: lightBkg
    width: 200
    height: 100
    radius: 20

    // define three buttons for (close, minimize, maximize)
    Row {
        anchors.top: parent.top
        anchors.right: parent.right
        padding: 10
        spacing: 6

        RoundedButton {
            id: minimizeButton
            color: "#2DFF76"
            onButtonClicked: root.showMinimized()
        }

        RoundedButton {
            id: maximizeButton
            color: "#FFF336"
        }

        RoundedButton {
            id: exitButton
            color: "#FF4B4B"
            onButtonClicked: Qt.quit()
        }
    }

    Text {
        anchors.centerIn: parent
        text: qsTr("This is a rectangle inside a separate window")
        font.pixelSize: 20
    }
}

