import QtQuick
import QtQuick.Effects
import QtQuick.Controls

// Create a rectangle for the top bar
Rectangle {
    id: topBar

    property bool isDarkMode : true
    Colors { id: themeColors }

    color: isDarkMode ? themeColors.semiDarkBkg : themeColors.semiLightBkg

    // Create mouse area to move the root window with the top bar
    // pass the x, y offsets in a signal

    signal moveCoord(int xOffset, int yOffset)
    MouseArea {
        anchors.fill: parent
        onClicked: {
            // Handle click event if needed
        }

        property int mouseXStart: 0
        property int mouseYStart: 0

        onPressed: {
            // Capture initial mouse position relative to window
            mouseXStart = mouseX
            mouseYStart = mouseY
        }

        onPositionChanged: {
            // Move the window when dragging
            var x = mouseX - mouseXStart
            var y = mouseY - mouseYStart
            moveCoord(x, y)
        }
    }

    // define three buttons for (close, minimize, maximize)
    Row {
        id: controlButtonsRow
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.margins: 10
        spacing: 6

        RoundedButton {
            id: minimizeButton
            color: isDarkMode ? "#2DFF76" : "mediumseagreen"
            onButtonClicked: root.showMinimized()
        }

        RoundedButton {
            id: maximizeButton
            color: isDarkMode ? "#FFF336" : "goldenrod"
        }

        RoundedButton {
            id: exitButton
            color: "#FF4B4B"
            onButtonClicked: Qt.quit()
        }
    }

    signal toggleDarkMode()  // custom signal to change theme in main
    // Create a switch button to switch between light and dark theme
    Switch {
        id: themeMode
        anchors.right: controlButtonsRow.left
        anchors.verticalCenter: parent.verticalCenter

        onCheckedChanged:
        {
            toggleDarkMode();
        }

        indicator: Rectangle {
            width: 50
            height: 26
            anchors.centerIn: parent
            radius: 13
            color: themeMode.checked ? "black" : "white"

            Rectangle {
                x: themeMode.checked ? parent.x + width / 2 + 2 : parent.x - width / 2 + 4
                y: parent.height / 2 - height / 2
                width: 24
                height: 24
                radius: 12
                color: themeMode.checked ? "white" : "black"

                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: themeMode.checked ? "qrc:/resources/assets/moon1.svg" :
                                                "qrc:/resources/assets/sun1.svg"
                }

            }
        }
    }
}
