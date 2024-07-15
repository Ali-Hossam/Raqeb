import QtQuick

Rectangle {
    property int radius_: 50
    property color bkgColor: "#000000"
    property var paletteColors: []

    onBkgColorChanged: canvas.requestPaint()

    width: radius_ * 2 + 10
    height : width
    radius: 4
    color: "transparent"

    signal buttonClicked()

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var total = data.reduce((acc, val) => acc + val, 0);
            var currentAngle = -Math.PI / 2;

            // Draw donut segments
            for (var i = 0; i < paletteColors.length; i++) {
                var sliceAngle = 2 * Math.PI / paletteColors.length;
                ctx.beginPath();
                ctx.moveTo(width / 2, height / 2);
                ctx.arc(width / 2, height / 2, radius_, currentAngle, currentAngle + sliceAngle);
                ctx.closePath();

                // Set stroke properties
                ctx.strokeStyle = "#000000"; // Black stroke color
                ctx.lineWidth = 2; // Adjust thickness as needed

                // Fill and stroke the segment
                ctx.fillStyle = paletteColors[i];
                ctx.fill();
                ctx.stroke();

                currentAngle += sliceAngle;
            }

            // Draw center circle
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, radius_ / 1.8, 0, 2 * Math.PI);
            ctx.fillStyle = bkgColor;
            ctx.fill();

            // Set stroke properties
            ctx.strokeStyle = "#000000"; // Black stroke color
            ctx.lineWidth = 2; // Adjust thickness as needed
            ctx.fill();
            ctx.stroke();
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.color = Colors.isDarkMode ? "#33FFFFFF" : "gray";
        onExited: parent.color = "transparent"
        onPressed: {
            apply: buttonClicked()
        }
    }
}
