import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

Rectangle {
    property bool isDarkMode : true
    property int margin : 10
    Colors { id: themeColors }
    property var compColor : isDarkMode ? themeColors.greenColorsD : themeColors.greenColorsL;
    property int panelRadius : 20

    id: mainWindow
    color: isDarkMode ? themeColors.darkBkg : themeColors.lightBkg

    // define three panels (Temp panel, resources panel, disk panel)
    Column {
        id: controlButtonsRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.margins: margin
        spacing: margin


        Rectangle {
            id: tempPanel
            width: mainWindow.width - margin * 2
            height: 200
            radius: panelRadius
            color: isDarkMode ? themeColors.grayDarkBkg : themeColors.grayWhiteBkg

            Row {
                anchors.fill: parent
                Rectangle {
                    width: tempPanel.width / 2 - 2
                    height: tempPanel.height
                    color: "#00FFFFFF"
                    CircularSlider {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: parent.height + 20
                        radius: 62
                        label: "GPU"
                        sliderColor: compColor;
                        isDarkMode: mainWindow.isDarkMode
                    }
                }

                // Add a separator line between CPU/GPU sliders
                Rectangle {
                    width: 2
                    height: tempPanel.height - 20
                    anchors.verticalCenter: parent.verticalCenter
                    radius: width / 2
                    color: isDarkMode ? "gray" : "darkgray";
                }

                Rectangle {
                    width: tempPanel.width / 2 - 2
                    height: tempPanel.height
                    color: "#00FFFFFF"
                    CircularSlider {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: parent.height + 20
                        radius: 62
                        label: "CPU"
                        sliderColor: compColor;
                        isDarkMode: mainWindow.isDarkMode
                    }
                }
            }
        }

        Rectangle {
            id: resourcesPanel
            width: mainWindow.width - margin * 2
            height: 250
            radius: panelRadius
            color: isDarkMode ? themeColors.grayDarkBkg : themeColors.grayWhiteBkg

            Column {
                anchors.fill: parent
                spacing: margin
                anchors.margins: margin + 4

                Text {
                    text: "Resources"
                    font.family: "Ubuntu"
                    font.bold: true
                    font.pointSize: 12
                    color: isDarkMode ? "white" : "black"
                    anchors.horizontalCenter:  parent.horizontalCenter
                }

                Column{
                    spacing: 5
                    Text {
                        text: "cpu"
                        font.family: "Ubuntu"
                        font.bold: false
                        font.pointSize: 12
                        color: isDarkMode ? "white" : "black"
                        anchors.left: parent.left
                    }

                    UsageBar {
                        themeColor: compColor
                        isDarkMode: isDarkMode
                        width: resourcesPanel.width - 30
                        anchors.left: parent.left
                    }
                }

                Column {
                    spacing: 5
                    Text {
                        text: "memory"
                        font.family: "Ubuntu"
                        font.bold: false
                        font.pointSize: 12
                        color: isDarkMode ? "white" : "black"
                        anchors.left: parent.left
                    }

                    UsageBar {
                        themeColor: compColor
                        isDarkMode: isDarkMode
                        width: resourcesPanel.width - 30
                        anchors.left: parent.left
                    }
                }

                Column {
                    spacing: 5
                    Text {
                        text: "gpu"
                        font.family: "Ubuntu"
                        font.bold: false
                        font.pointSize: 12
                        color: isDarkMode ? "white" : "black"
                        anchors.left: parent.left
                    }

                    UsageBar {
                        themeColor: compColor
                        isDarkMode: isDarkMode
                        width: resourcesPanel.width - 30
                        anchors.left: parent.left
                    }
                }
            }
        }
        Rectangle {
            id: diskPanel
            width: mainWindow.width - margin * 2
            height: 150
            radius: panelRadius
            color: isDarkMode ? themeColors.grayDarkBkg : themeColors.grayWhiteBkg
        }

    }
}


