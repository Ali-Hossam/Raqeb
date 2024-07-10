#include "mousetracker.h"

MouseTracker::MouseTracker(QObject *parent)
    : QObject{parent}
{}

QPointF MouseTracker::getGlobalMousePosition()
{
    return QCursor::pos();
}
