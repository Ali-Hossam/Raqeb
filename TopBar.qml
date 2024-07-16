import QtQuick
import QtQuick.Effects
import QtQuick.Controls

// Create a rectangle for the top bar
Rectangle {
    id: topBar
    color: Colors.isDarkMode ? Colors.semiDarkBkg : Colors.semiLightBkg

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
            mainColor : Colors.isDarkMode ? "#2DFF76" : "mediumseagreen"
            hoverColor : "darkslategray"
            onButtonClicked: root.showMinimized()
        }

        RoundedButton {
            id: maximizeButton
            mainColor: Colors.isDarkMode ? "#FFF336" : "goldenrod"
            hoverColor: Colors.isDarkMode ? "#FFF336" : "goldenrod"

        }

        RoundedButton {
            id: exitButton
            mainColor: "#FF4B4B"
            hoverColor: "brown"
            onButtonClicked: root.visible = false
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

                // add animation
                Behavior on x {
                    PropertyAnimation {
                        duration: 500
                        easing.type: Easing.OutBounce
                    }
                }
            }
        }
    }

    PaletteButton {
        anchors.centerIn: parent
        radius_: 12
        bkgColor: topBar.color
        paletteColors: Colors.isDarkMode ? Colors.pColorsD : Colors.pColorsL;

        onButtonClicked: themesWindow.visible = !themesWindow.visible
    }

    ThemesWindow {
        id: themesWindow
        x: root.x + root.width / 2 - 50
        y: root.y - 65
        visible:false
        bkgColor: topBar.color
    }

    FontLoader {
        id: myFont
        source: "qrc:/resources/assets/fonts/ruqaa.ttf"
    }

    Text {
        x: 15
        y: -15
        text: "راقِب"
        font.family: myFont.font.family
        font.weight: myFont.font.weight
        font.styleName: myFont.font.styleName
        font.pixelSize: 38
        font.letterSpacing: 3
        color: Colors.isDarkMode ? "white" : "black"
    }
}

