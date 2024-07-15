import QtQuick
import QtQuick.Effects

Window {
    id: colorWindow
    visible: false
    height: 60
    width: 90
    color: "transparent"

    flags: Qt.FramelessWindowHint | Qt.Window
    property color bkgColor : "#000000"

    Rectangle {
        id: colorsRect
        width: parent.width - 5
        height: parent.height - 5
        anchors.centerIn: parent
        radius: 10
        color: bkgColor // Background color of the rectangle

        Grid {
            anchors.centerIn: parent
            spacing: 8 // Adjust spacing between circles

            columns: 3
            Repeater {
                model: Colors.themesLight.length // Repeater to create circles for each color

                Rectangle {
                    width: 16
                    height: width
                    radius: width/2
                    color: Colors.isDarkMode ?
                               Colors.themesDark[index][1] :
                               Colors.themesLight[index][1] // Set color from themes.themesLight array

                    border.color: "transparent"
                    border.width: 3

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.border.color = Colors.isDarkMode ? "white" : "black"
                        onExited: parent.border.color = "transparent"

                        onClicked: {
                            Colors.themeIdx = index
                            Colors.themeArr = Colors.isDarkMode ?
                                                Colors.themesDark :
                                                Colors.themesLight;

                            Colors.theme = Colors.themeArr[Colors.themeIdx]
                            colorWindow.close()
                        }
                    }
                }
            }
        }
    }

    MultiEffect {
        source: colorsRect
        anchors.fill: colorsRect
        shadowBlur: 0.5
        shadowOpacity: 0.2
        shadowEnabled: true
        shadowColor: "black"
        shadowHorizontalOffset: 3
        shadowVerticalOffset: 0
    }
}

// buttons colors - button action when pressed - animation
