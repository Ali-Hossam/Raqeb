import QtQuick

Item {
    property var theme : []
    property int newUsage : 0

    onThemeChanged: pie.requestPaint()

    onNewUsageChanged:
    {
        timer_.start()
    }

    Canvas {
        id: pie
        width: 300
        height: 150
        anchors.centerIn:parent
        property int radius : 60
        property bool isDarkMode : Colors.isDarkMode
        property var data : [90, 10];   // Two sections data

        // onDataChanged: pie.requestPaint()
        onIsDarkModeChanged: pie.requestPaint()

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var labels = ["Used", "Free"]; // Labels for the legend
            var total = 100
            var currentAngle = -Math.PI / 2;
            var explodeIndex = 0; // Index of the exploded slice
            var explodeDistance = radius / 5; // Distance to explode the slice

            for (var i = 0; i < data.length; i++) {
                var sliceAngle = (data[i] / total) * 2 * Math.PI;
                var midAngle = currentAngle + sliceAngle / 2;

                // Calculate the position of the exploded slice
                var explodeX = 0, explodeY = 0;
                if (i === explodeIndex) {
                    explodeX = Math.cos(midAngle) * explodeDistance;
                    explodeY = Math.sin(midAngle) * explodeDistance;
                }

                // Draw the slice
                ctx.beginPath();
                ctx.moveTo(width / 2 + explodeX, height / 2 + explodeY);
                ctx.arc(width / 2 + explodeX, height / 2 + explodeY, radius, currentAngle, currentAngle + sliceAngle);
                ctx.closePath();
                ctx.fillStyle = theme[i];
                ctx.fill();

                // Draw the percentage text
                var percentage = ((data[i] / total) * 100).toFixed(1) + "%";
                ctx.fillStyle = "black";
                ctx.font = "bold 12px Ubuntu";
                ctx.textAlign = "center";
                ctx.textBaseline = "middle";
                var textX = width / 2 + explodeX + 1.2 * Math.cos(midAngle) * (radius - 30);
                var textY = height / 2 + explodeY + 1.2 * Math.sin(midAngle) * (radius - 30);
                ctx.fillText(percentage, textX, textY);

                currentAngle += sliceAngle;
            }

            // Draw the legend
            var legendX = width - 60; // Position of the legend
            var legendY = 20;
            var legendHeight = 20;
            var legendRadius = 5;

            for (var j = 0; j < labels.length; j++) {
                // Draw legend color circle
                ctx.fillStyle = theme[j];
                ctx.beginPath();
                ctx.arc(legendX + 10, legendY + j * legendHeight + 10, legendRadius, 0, 2 * Math.PI);
                ctx.fill();

                // Draw legend text
                ctx.fillStyle = Colors.isDarkMode ? "white" : "black";
                ctx.font = "12px Ubuntu";
                ctx.textAlign = "left";
                ctx.textBaseline = "middle";
                ctx.fillText(labels[j], legendX + 30, legendY + j * legendHeight + 10); // 30 is the offset from the color circle
            }
        }
    }

    Timer {
        id: timer_
        interval: 16
        running:false
        repeat: true
        property double step : 0.5

        onTriggered: {
            if (pie.data[0] < newUsage) {
                pie.data[0] += step
            } else if (pie.data[0] > newUsage)
                pie.data[0] -= step

            pie.data[1] = 100 - pie.data[0]
            pie.requestPaint()
        }
    }

}
