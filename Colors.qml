import QtQuick

Item {
    id: colors

    // Light theme Colors
    property color lightBkg: "#FFFFFF"
    property color semiLightBkg : "#CCCCCC"
    property color grayWhiteBkg : "#19000000"

    // Dark theme Colors
    property color darkBkg: "#121212"
    property color semiDarkBkg : "#323232"
    property color grayDarkBkg : "#1FFFFFFF"

    // Components colors
    property var redColorsD : ["#FFEAEA", "#FF3D3D", "#7A0000"]
    property var greenColorsD : ["#E0FFEB", "#82FFB7", "#00B385"]
    property var yellowColorsD : ["#FFFFE0", "#FFFF76", "#B3B300"]
    property var blueColorsD : ["#E0F0FF", "#76D7FF", "#007AB3"]
    property var magentaColorsD : ["#FFE0FF", "#FF76FF", "#B300B3"]
    property var whiteColorsD : ["#FFFFFF", "#F0F0F0", "#CCCCCC"]

    property var redColorsL : ["#FF6666", "#CC0000", "#7A0000"]
    property var greenColorsL : ["#8AA49A", "#358867", "#1A3F31"]
    property var yellowColorsL : ["#FFFF66", "#CCCC00", "#999900"]
    property var blueColorsL : ["#66B2FF", "#0059B3", "#003366"]
    property var magentaColorsL : ["#FF66FF", "#B300B3", "#660066"]
    property var whiteColorsL : ["#333333", "#666666", "#999999"]

    // availabe themes colors (dark / light)
    property var themesLight : [
        redColorsL,
        greenColorsL,
        yellowColorsL,
        blueColorsL,
        magentaColorsL,
        whiteColorsL,]

    property var themesDark : [
        redColorsD,
        greenColorsD,
        yellowColorsD,
        blueColorsD,
        magentaColorsD,
        whiteColorsD,]



    // Palette Button colors
    property var pColorsD : [
        "#ff6666",
        "#ffff66",
        "#66ff66",
        "#66ffff",
        "#6666ff",
        "#ff66ff"
    ];

    property var pColorsL: [
        "#ff0000",
        "#ffff00",
        "#00ff00",
        "#00ffff",
        "#0000ff",
        "#ff00ff"
    ]

}
