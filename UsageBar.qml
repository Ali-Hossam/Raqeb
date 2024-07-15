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
            color: handle_.color
            radius: handle_.radius
        }

        // add a panel to display text in
        Rectangle {
            width : 50
            height: parent.height - 6
            color: "white"
            radius: 3
            anchors.verticalCenter: parent.verticalCenter
            x: control.value < 30 ? handle_.x + 15 : parent.x + 10

            Text {
                text: control.value.toFixed(1) + "%"
                font.family: "Ubuntu"
                font.bold: true
                font.pointSize: 10
                anchors.centerIn: parent
            }

            // add animation to the slider text panel
            Behavior on x {
                PropertyAnimation {
                    duration: 500
                    easing.type: Easing.OutExpo
                }
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
        color: Colors.isDarkMode ? Colors.theme[1] : Colors.theme[2];

    }
}

