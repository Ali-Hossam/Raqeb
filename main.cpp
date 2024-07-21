#include <QQmlApplicationEngine>
#include <QApplication>
#include <QIcon>
#include "C++/Header/Memory.h"
#include "C++/Header/cpu.h"
#include "C++/Header/disk.h"
#include "C++/Header/gpu.h"

#include <QQmlContext>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    // set application name !
    app.setApplicationName("Raqeb");

    // set window Icon !
    app.setWindowIcon(QIcon(":/resources/assets/icons/spy.svg"));

    Memory memoryObj;
    Cpu cpuObj;
    Disk diskObj;
    Gpu gpuObj;


    QQmlApplicationEngine engine;

    QQmlContext * rootContext = engine.rootContext();
    rootContext->setContextProperty("Memory", &memoryObj);
    rootContext->setContextProperty("Cpu", &cpuObj);
    rootContext->setContextProperty("Disk", &diskObj);
    rootContext->setContextProperty("Gpu", &gpuObj);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    return app.exec();
}
