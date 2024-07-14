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
import MouseTracker

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

    property bool isDarkMode_ : true
    property int cornerRadius : 15
    property int shadowOffset : 10

    TopBar {
        id: topBar
        width: parent.width - shadowOffset
        height: 36
        topLeftRadius: cornerRadius
        topRightRadius: cornerRadius
        isDarkMode: isDarkMode_

        Connections {
            function onMoveCoord(xOffset, yOffset) {
                root.x += xOffset
                root.y += yOffset
            }
        }

        Connections {
            function onToggleDarkMode() {
                isDarkMode_ = !isDarkMode_
            }
        }
    }

    MonitorWindow {
        id: mainWindow
        width: parent.width - shadowOffset
        height: parent.height - topBar.height - shadowOffset
        y: topBar.height
        isDarkMode: isDarkMode_
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
        shadowHorizontalOffset: 4
        shadowVerticalOffset: 4
    }


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


    // ------------------------------------------------------------------
    // DELETE LATER
    // Track mouse position to show window when the tray icon is pressed
    MouseTracker {
        id: mouse_t
    }

    // Create system Tray icon for the monitor widget
    SystemTrayIcon {
        id: monitorIcon
        icon.mask: true
        visible: true
        icon.source: "qrc:/resources/assets/koala_dark.png"


        menu: Menu {
            MenuItem {
                text: qsTr("SysWatch")
                onTriggered:
                {
                    rectangleWindow.visible = true
                    console.log(mouse_t.getGlobalMousePosition().x)
                    console.log(mouse_t.getGlobalMousePosition().y)
                    rectangleWindow.x = mouse_t.getGlobalMousePosition().x
                    rectangleWindow.y =  mouse_t.getGlobalMousePosition().y

                }
            }
            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }
    }


    // the shadow fills the root window !!!
}
