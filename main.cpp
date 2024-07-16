#include <QQmlApplicationEngine>
#include <QApplication>
#include <QIcon>
#include "mousetracker.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    // set application name !
    app.setApplicationName("Raqeb");

    // set window Icon !
    app.setWindowIcon(QIcon(":/resources/assets/spy.png"));

    qmlRegisterType<MouseTracker>("MouseTracker", 1, 0, "MouseTracker");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    return app.exec();
}
