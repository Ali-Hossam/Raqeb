import QtQuick 2.15

Rectangle {
    id: rbutton
    width: 14
    height: width
    radius: width / 2
    color: "gray"

    signal hover()
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPressed: {
            apply: buttonClicked()
        }
    }

    signal buttonClicked()
}
