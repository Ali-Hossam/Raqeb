QT += quick
QT += widgets


# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        C++/Source/Memory.cpp \
        C++/Source/cpu.cpp \
        C++/Source/disk.cpp \
        C++/Source/gpu.cpp \
        main.cpp

RESOURCES += qml.qrc \
    resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    C++/Header/Memory.h \
    C++/Header/cpu.h \
    C++/Header/disk.h \
    C++/Header/gpu.h

DISTFILES += \
    qml/CircularSlider.qml \
    qml/Colors.qml \
    qml/MonitorWindow.qml \
    qml/PaletteButton.qml \
    qml/PiePlot.qml \
    qml/RoundedButton.qml \
    qml/ThemesWindow.qml \
    qml/TopBar.qml \
    qml/UsageBar.qml \
    qml/main.qml \
    qml/qmldir
