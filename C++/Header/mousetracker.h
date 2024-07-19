#ifndef MOUSETRACKER_H
#define MOUSETRACKER_H

#include <QObject>
#include <QPoint>
#include <qcursor.h>

class MouseTracker : public QObject
{
    Q_OBJECT
public:
    explicit MouseTracker(QObject *parent = nullptr);

    Q_INVOKABLE QPointF getGlobalMousePosition();

signals:
};

#endif // MOUSETRACKER_H
