import QtQuick
import QtQuick.Controls

Rectangle {
    property bool isDarkMode : true
    Colors { id: themeColors }

    id: mainWindow
    color: isDarkMode ? themeColors.darkBkg : themeColors.lightBkg

    Text {
        anchors.centerIn: parent
        text: qsTr("This is a rectangle inside a separate window")
        font.pixelSize: 20
    }


    signal toggleDarkMode()  // custom signal to change theme in main
    // Create a switch button to switch between light and dark theme
    Switch {
        id: themeMode
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 10
        onCheckedChanged:
        {
            toggleDarkMode();
        }

        indicator: Rectangle {
            implicitWidth: 50
            implicitHeight: 26
            anchors.right: parent.right
            radius: 13
            color: themeMode.checked ? "black" : "white"

            Rectangle {
                x: themeMode.checked ? parent.x + 5 : parent.x - width / 2 - 5
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
