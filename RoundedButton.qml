/* custom made component used for control buttons
such as exit, minimize and maximize*/

import QtQuick


Rectangle {
    id: rbutton
    width: 14
    height: width
    radius: width / 2
    color: mainColor

    property color mainColor : "#000000"
    property color hoverColor : "#000000"

    // change the color when main colors changes with dark mode toggle
    onMainColorChanged: color = mainColor

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.color = hoverColor
        onExited: parent.color = mainColor

        onPressed: {
            apply: buttonClicked()
        }
    }

    signal buttonClicked()
}
