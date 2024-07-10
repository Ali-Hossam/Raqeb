import QtQuick 2.15

Rectangle {
    id: rbutton
    width: 14
    height: width
    radius: width / 2
    color: "gray"

    MouseArea {
        anchors.fill: parent
        onPressed: {
            apply: buttonClicked()
        }
    }

    signal buttonClicked()
}
