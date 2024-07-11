import QtQuick
import QtQuick.Effects

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
        anchors.top: parent.top
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
}
