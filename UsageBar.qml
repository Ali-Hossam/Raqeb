import QtQuick
import QtQuick.Controls

Slider {
    id: control
    from: 1
    to: 100

    background : Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 30
        width: control.availableWidth
        height: implicitHeight
        radius: 6

        color: Colors.isDarkMode ? Colors.grayDarkBkg : "lightgray";

        Rectangle {
            width: control.visualPosition * parent.width + radius
            height: parent.height
            color: Colors.isDarkMode ? Colors.theme[1] : Colors.theme[2];
            radius: handle_.radius
        }

        // add a panel to display text in
        Rectangle {
            id: textPanel
            width : 50
            height: parent.height - 6
            color: "white"
            radius: 3
            anchors.verticalCenter: parent.verticalCenter
            x: control.value < 83 ? handle.x + 15 : parent.width - 55

            Text {
                text: control.value.toFixed(1) + "%"
                font.family: "Ubuntu"
                font.bold: true
                font.pointSize: 10
                anchors.centerIn: parent
            }
        }
    }

    handle : Rectangle {
        id: handle_
        implicitWidth: 10
        implicitHeight: 30
        radius: 6
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        color: "transparent"
    }

    Behavior on value {
        PropertyAnimation {
            target: control
            property: "value"
            duration: 2000
            easing.type: Easing.OutQuad
        }
    }

    // disable mouse inputs to the slider
    MouseArea {
           anchors.fill: parent
           enabled: true // Block mouse events to the slider
       }
}
