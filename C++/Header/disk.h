#ifndef DISK_H
#define DISK_H

#include <QObject>
#include <QTimer>
#include <QDebug>

class Disk : public QObject
{
    Q_OBJECT
public:
    explicit Disk(QObject *parent = nullptr);
    Q_PROPERTY(double diskUsage READ getDiskUsage NOTIFY diskUsageChanged FINAL)

    // getter
    double getDiskUsage() const;

signals:
    void diskUsageChanged();

private slots:
    void fetchDiskUsage();

private:
    QTimer m_timer;
    double diskUsage_ = 0.0;

};

#endif // DISK_H
