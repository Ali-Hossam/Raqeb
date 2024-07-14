import QtQuick

Canvas {
    id: pie
    width: 300
    height: 100

    property bool isDarkMode : true
    property int radius : 60
    property var theme : []

    onIsDarkModeChanged: pie.requestPaint()
    onThemeChanged: pie.requestPaint()

    onPaint: {
        var ctx = getContext("2d");
        ctx.clearRect(0, 0, width, height);

        var data = [70, 30]; // Two sections data
        var labels = ["Used", "Free"]; // Labels for the legend
        var total = data.reduce((acc, val) => acc + val, 0);
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
            var textX = width / 2 + explodeX + Math.cos(midAngle) * (radius - 30);
            var textY = height / 2 + explodeY + Math.sin(midAngle) * (radius - 30);
            ctx.fillText(percentage, textX, textY);

            currentAngle += sliceAngle;
        }

        // Draw the legend
        var legendX = width - 60; // Position of the legend
        var legendY = 20;
        var legendHeight = 20;
        var legendRadius = 5;

        for (var i = 0; i < labels.length; i++) {
            // Draw legend color circle
            ctx.fillStyle = theme[i];
            ctx.beginPath();
            ctx.arc(legendX + 10, legendY + i * legendHeight + 10, legendRadius, 0, 2 * Math.PI);
            ctx.fill();

            // Draw legend text
            ctx.fillStyle = isDarkMode ? "white" : "black";
            ctx.font = "12px Ubuntu";
            ctx.textAlign = "left";
            ctx.textBaseline = "middle";
            ctx.fillText(labels[i], legendX + 30, legendY + i * legendHeight + 10); // 30 is the offset from the color circle
        }
    }
}
