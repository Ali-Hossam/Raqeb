import QtQuick
import QtQuick.Controls

Item {
    property int radius: 100
    property int sliderRadius: radius - 18
    property string label : ""
    property var sliderColor : []
    property bool isDarkMode : true

    onIsDarkModeChanged: sliderCirc.requestPaint()

    Canvas {
        id: sliderCirc
        anchors.fill: parent
        property real currentAngle: 0   // slider current angle
        property int nextAngle: 0   // the request next angle of the slider
        property double angleOffset : Math.PI * 120 / 180  // to make slider starts at angle 120

        onPaint: {
            var ctx = getContext("2d");
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
            gradient.addColorStop(0.4, sliderColor[1]);
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
            ctx.lineWidth = 1;

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
            ctx.fillStyle = isDarkMode ? "white" : "black";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            // Draw the text
            ctx.fillText(label, centerX, centerY + radius + 30);
        }
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
                sliderCirc.requestPaint();            }
        }


    Column {
        anchors.centerIn: parent

        Button {
            text: "I"
            onClicked: {
                if (sliderCirc.currentAngle <= 290) {
                    sliderCirc.nextAngle = Math.min(sliderCirc.nextAngle + 10, 290); // Increment nextAngle by 10, but not exceed 360
                    timer_.start();
                } else {
                    sliderCirc.currentAngle = 0;
                    sliderCirc.nextAngle = 10;
                    timer_.start();
                }
            }
        }

        Button {
            text: "D"
            onClicked: {
                sliderCirc.nextAngle = Math.max(sliderCirc.nextAngle - 10, 0); // Increment nextAngle by 10, but not exceed 360
                timer_.start();
                console.log(isDarkMode)
            }
        }
    }
}
