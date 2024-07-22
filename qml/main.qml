/*
system monitor widget should have the following:
1. Usage (CPU - Memory - GPU - Network - Disk)
2. Temperature (CPU - GPU)
*/

import QtQuick
import QtQuick.Window
import Qt.labs.platform
import QtQuick.Controls
import QtQuick.Effects

Window {
    id: root
    width: 450 + shadowOffset
    height: 720 + shadowOffset
    visible: true
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window

    // disable window resizing
    minimumHeight: height; maximumHeight: height
    minimumWidth: width; maximumWidth: width

    // main window corner radius and shadow offset
    property int cornerRadius : 15
    property int shadowOffset : 10

    // define the top bar having control buttons, and logo
    TopBar {
        id: topBar
        width: parent.width - shadowOffset
        height: 40
        x: shadowOffset / 2
        topLeftRadius: cornerRadius
        topRightRadius: cornerRadius

        Connections {
            function onMoveCoord(xOffset, yOffset) {
                root.x += xOffset
                root.y += yOffset
            }
        }

        Connections {
            function onToggleDarkMode() {
                Colors.isDarkMode = !Colors.isDarkMode
                Colors.themeArr = Colors.themeArr == Colors.themesDark ?
                            Colors.themesLight : Colors.themesDark;

                Colors.theme = Colors.themeArr[Colors.themeIdx]
            }
        }
    }

    // define the main window of the application
    MonitorWindow {
        id: mainWindow
        width: parent.width - shadowOffset
        height: parent.height - topBar.height - shadowOffset
        x: shadowOffset / 2
        y: topBar.height
        bottomLeftRadius: cornerRadius
        bottomRightRadius: cornerRadius
    }


    // Create shadow for the main window
    MultiEffect {
        source: mainWindow
        anchors.fill: mainWindow
        shadowBlur: 0.5
        shadowOpacity: 0.2
        shadowEnabled: true
        shadowColor: "black"
        // shadowHorizontalOffset: 4
        // shadowVerticalOffset: 4
    }

    // create shadow for the top bar
    MultiEffect {
        source: topBar
        anchors.fill: topBar
        shadowBlur: 0.5
        shadowOpacity: 0.2
        shadowEnabled: true
        shadowColor: "black"
        shadowHorizontalOffset: 3
        shadowVerticalOffset: 0
    }

    // create system tray icon for the application
    SystemTrayIcon {
        id: monitorIcon
        icon.mask: true
        visible: true
        icon.source: "qrc:/resources/assets/icons/spy.svg"

        menu: Menu {
            MenuItem {
                text: qsTr("Raqeb")
                onTriggered:
                {
                    root.visible = true;
                    root.requestActivate()
                }
            }

            MenuSeparator {}

            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }
    }
}
