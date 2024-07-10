import QtQuick 2.15
import QtQuick.Window 2.15
import Qt.labs.platform 1.1
import QtQuick.Controls
import MouseTracker

Window {
    id: root
    width: 450
    height: 600
    visible: true
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window

    // disable window resizing
    minimumHeight: height; maximumHeight: height
    minimumWidth: width; maximumWidth: width

    MonitorWindow {
        width: parent.width
        height: parent.height
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

    // // Separate window for displaying the rectangle
    // Window {
    //     id: rectangleWindow
    //     visible: false
    //     width: 300
    //     height: 200
    //     title: qsTr("Rectangle Window")

    //     MonitorWindow {}
    // }

}
