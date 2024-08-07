import QtQuick
import QtQuick.Controls

Item {
    property int radius: 65     // outter circle radius
    property int sliderRadius: radius - 18
    property string label : ""  // label under the slider
    property var sliderColor : []
    property bool isDarkMode : Colors.isDarkMode
    property int temp : 0

    onTempChanged:
    {
        // map temp from 0 - 120 to angle from 0 - 290
        sliderCirc.nextAngle = (temp - 0) * (290 - 0) / (120 - 0) + 0
    }

    // paint update
    onIsDarkModeChanged: sliderCirc.requestPaint()
    onSliderColorChanged: sliderCirc.requestPaint()

    Canvas {
        id: sliderCirc
        anchors.fill: parent
        property real currentAngle: 0   // slider current angle
        property double angleOffset : Math.PI * 120 / 180  // to make slider starts at angle 120
        property int nextAngle: 0   // the request next angle of the slider

        onPaint: {
            var ctx = getContext("2d");

            // circle coordinates
            var centerX = sliderCirc.width / 2
            var centerY = sliderCirc.height / 2

            ctx.clearRect(0, 0, sliderCirc.width, sliderCirc.height);

            // Draw full circle
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
            ctx.strokeStyle = "black";
            ctx.lineWidth = 5;
            ctx.stroke();

            // Create linear gradient for the inner arc
            var gradient = ctx.createLinearGradient(
                        centerX - 80, centerY,
                        centerX + 80, centerY
                        );
            gradient.addColorStop(0, sliderColor[0]);
            gradient.addColorStop(0.5, sliderColor[1]);
            gradient.addColorStop(1, sliderColor[2]);

            // Draw arc with gradient and rounded edges
            ctx.beginPath();
            ctx.arc(centerX, centerY, sliderRadius, angleOffset,  angleOffset + (currentAngle * Math.PI / 180)); // Convert currentAngle to radians
            ctx.strokeStyle = gradient;
            ctx.lineWidth = 18;
            ctx.lineCap = "round";
            ctx.stroke();

            // Draw a mark at the beginning of the arc
            var markRadius = 6;
            var markX = centerX + (sliderRadius * Math.cos(angleOffset + currentAngle * Math.PI / 180));
            var markY = centerY + (sliderRadius * Math.sin(angleOffset + currentAngle * Math.PI / 180));
            ctx.beginPath();
            ctx.arc(markX, markY, markRadius, 0, 2 * Math.PI);
            ctx.fillStyle = "black";
            ctx.fill();

            // Draw dashes
            var dashRadius = radius + 10;
            var dashLength = dashRadius / 10;
            var numDashes = 20;
            var angleIncrement = (2 * Math.PI) / numDashes;

            ctx.strokeStyle = sliderColor[1];
            ctx.lineWidth = 3;

            for (var i = 7; i < numDashes + 4; i++) {
                var angle = i * angleIncrement;
                var startX = centerX + (dashRadius * Math.cos(angle));
                var startY = centerY + (dashRadius * Math.sin(angle));
                var endX = centerX + ((dashRadius+ dashLength) * Math.cos(angle));
                var endY = centerY + ((dashRadius + dashLength) * Math.sin(angle));

                ctx.beginPath();
                ctx.moveTo(startX, startY);
                ctx.lineTo(endX, endY);
                ctx.stroke();
            }

            // Set the font properties
            ctx.font = "bold 16px Ubuntu";
            ctx.fillStyle = Colors.isDarkMode ? "white" : "black";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            // Draw the text
            ctx.fillText(label, centerX, centerY + radius + 24);
        }

        onNextAngleChanged: timer_.start()
    }

    // Create a timer to smooth transition between different angles
    Timer {
        id: timer_
        interval: 16
        running: false
        repeat: true
        property double step : 0.5

        onTriggered: {
            if (sliderCirc.currentAngle < sliderCirc.nextAngle) {
                sliderCirc.currentAngle += step; // Increment step
                sliderCirc.requestPaint();

            } else if (sliderCirc.currentAngle > sliderCirc.nextAngle )
                sliderCirc.currentAngle -= step; // decrement step
            sliderCirc.requestPaint();
        }
    }

    // add temperature text
    Text {
        id: temperature
        text: temp.toString() + "°C"
        font.bold: true
        font.pointSize: 16
        font.kerning: false
        anchors.centerIn: parent
        color: Colors.isDarkMode ? "white" : "black"
    }

    // add temperatuer icon image
    IconImage {
        source: "qrc:/resources/assets/icons/temp.png"
        x: temperature.x + 20
        y: temperature.y - 20
        width: 20
        fillMode: Image.PreserveAspectFit
        color: Colors.theme[1]
    }
}
