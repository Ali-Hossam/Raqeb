pragma Singleton
import QtQuick

Item {
    id: colors

    // Current theme, dark or light
    property var theme : themeArr[themeIdx]
    property var themeArr : themesDark
    property int themeIdx: 0
    property bool isDarkMode : true

    // Light theme Colors
    property color lightBkg: "#FFFFFF"
    property color semiLightBkg : "#CCCCCC"
    property color grayWhiteBkg : "#19000000"

    // Dark theme Colors
    property color darkBkg: "#121212"
    property color semiDarkBkg : "#323232"
    property color grayDarkBkg : "#1FFFFFFF"

    // Components colors
    property var redColorsD : ["#EF9A9A", "#FF4B4B", "#B71C1C"]
    property var greenColorsD : ["#E0FFEB", "#82FFB7", "#00B385"]
    property var yellowColorsD : ["#FFFFE0", "#FFFF76", "#ff7b00"]
    property var blueColorsD : ["#E0F0FF", "#4284FF", "#002AB9"]
    property var magentaColorsD : ["#F5EBFF", "#b892ff", "#6302BC"]
    property var whiteColorsD : ["#FFFFFF", "#F0F0F0", "#CCCCCC"]

    property var redColorsL : ["#FF6666", "#CC0000", "#7A0000"]
    property var greenColorsL : ["#8AA49A", "#358867", "#1A3F31"]
    property var yellowColorsL : ["#ffaa00", "#ff8800", "#fdb833"]
    property var blueColorsL : ["#66B2FF", "#0059B3", "#003366"]
    property var magentaColorsL : ["#c77dff", "#3c096c", "#240046"]
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

    property var piePlotThemes: [
        // Red theme
        ["#6B2737", "#F26D7D"],
        // Green theme
        ["#35654D", "#79B791"],
        // Yellow theme
        ["#ffbc42", "#E5D876"],
        // Blue theme
        ["#0d47a1", "#90caf9"],
        // Magenta theme
        ["#54318c", "#caadff"],
        // White theme
        ["#555555", "#AAAAAA"]
    ];
}
