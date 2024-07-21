/*
This file contains the main componenets of the widget including resources, temp and disk panels
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

Rectangle {
    property int margin : 10
    property int panelRadius : 20


    id: mainWindow
    color: Colors.isDarkMode ? Colors.darkBkg : Colors.lightBkg

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
            height: 220
            radius: panelRadius
            color: Colors.isDarkMode ? Colors.grayDarkBkg : Colors.grayWhiteBkg

            Column {
                anchors.fill: parent
                anchors.topMargin: margin + 4

                Text {
                    id: tempText
                    text: "Temperature"
                    font.family: "Ubuntu"
                    font.bold: true
                    font.pointSize: 12
                    color: Colors.isDarkMode ? "white" : "black"
                    anchors.horizontalCenter:  parent.horizontalCenter
                }

            Row {
                Rectangle {
                    width: tempPanel.width / 2 - 2
                    height: tempPanel.height - tempText.height - 25
                    color: "#00FFFFFF"
                    CircularSlider {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: parent.height + 20
                        label: "CPU"
                        sliderColor: Colors.theme;
                        temp: Cpu.cpuTemp
                    }
                }

                // Add a separator line between CPU/GPU sliders
                Rectangle {
                    width: 2
                    height: 120
                    anchors.verticalCenter: parent.verticalCenter
                    radius: width / 2
                    color: Colors.isDarkMode ? "gray" : "darkgray";
                }

                Rectangle {
                    width: tempPanel.width / 2 - 2
                    height: tempPanel.height - tempText.height - 25
                    color: "#00FFFFFF"
                    CircularSlider {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: parent.height + 20
                        label: "GPU"
                        sliderColor: Colors.theme;
                        temp: Gpu.gpuTemp
                    }
                }
            }
        }
        }

        Rectangle {
            id: resourcesPanel
            width: mainWindow.width - margin * 2
            height: 230
            radius: panelRadius
            color: Colors.isDarkMode ? Colors.grayDarkBkg : Colors.grayWhiteBkg

            Column {
                anchors.fill: parent
                spacing: margin - 4
                anchors.margins: margin + 4

                Text {
                    text: "Resources"
                    font.family: "Ubuntu"
                    font.bold: true
                    font.pointSize: 12
                    color: Colors.isDarkMode ? "white" : "black"
                    anchors.horizontalCenter:  parent.horizontalCenter
                }

                Column{
                    spacing: 5
                    Text {
                        text: "cpu"
                        font.family: "Ubuntu"
                        font.bold: false
                        font.pointSize: 12
                        color: Colors.isDarkMode ? "white" : "black"
                        anchors.left: parent.left
                    }

                    UsageBar {
                        id: cpuUsageBar
                        width: resourcesPanel.width - 30
                        anchors.left: parent.left
                        value: Cpu.cpuUsage
                    }
                }

                Column {
                    spacing: 5
                    Text {
                        text: "memory"
                        font.family: "Ubuntu"
                        font.bold: false
                        font.pointSize: 12
                        color: Colors.isDarkMode ? "white" : "black"
                        anchors.left: parent.left
                    }

                    UsageBar {
                        id: memUsageBar
                        width: resourcesPanel.width - 30
                        anchors.left: parent.left
                        value: Memory.memUsage
                    }
                }

                Column {
                    spacing: 5
                    Text {
                        id: gpuUsageBar
                        text: "gpu"
                        font.family: "Ubuntu"
                        font.bold: false
                        font.pointSize: 12
                        color: Colors.isDarkMode ? "white" : "black"
                        anchors.left: parent.left
                    }

                    UsageBar {
                        width: resourcesPanel.width - 30
                        anchors.left: parent.left
                        value: Gpu.gpuUsage
                    }
                }
            }
        }
        Rectangle {
            id: diskPanel
            width: mainWindow.width - margin * 2
            height: 190
            radius: panelRadius
            color: Colors.isDarkMode ? Colors.grayDarkBkg : Colors.grayWhiteBkg

            Column {
                anchors.fill: parent
                spacing: margin
                anchors.margins: margin + 4

                Text {
                    id: diskText
                    text: "Disk Usage"
                    font.family: "Ubuntu"
                    font.bold: true
                    font.pointSize: 12
                    color: Colors.isDarkMode ? "white" : "black"
                    anchors.horizontalCenter:  parent.horizontalCenter
                }

                PiePlot {
                    anchors.top: diskText.bottom
                    anchors.horizontalCenter: diskText.horizontalCenter
                    anchors.topMargin: 6

                    height: parent.height - margin * 2.2
                    theme: Colors.piePlotThemes[Colors.themeIdx]
                    newUsage: Disk.diskUsage
                }
            }


        }

    }
}


