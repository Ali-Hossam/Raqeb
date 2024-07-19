#ifndef CPU_H
#define CPU_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <iostream>
#include <fstream>
#include <sstream>

#include <sys/statvfs.h>
#include <dirent.h>

// struct that stores cpu info from /proc/stat
struct CpuTimes {
    long long user;
    long long nice;
    long long system;
    long long idle;
    long long iowait;
    long long irq;
    long long softirq;
    long long steal;
    long long guest;
    long long guest_nice;
};

class Cpu : public QObject
{
    Q_OBJECT
public:
    explicit Cpu(QObject *parent = nullptr);

    // usage property variable
    Q_PROPERTY(double cpuUsage READ getCpuUsage NOTIFY cpuUsageChanged FINAL)

    // // temp property variables
    Q_PROPERTY(int cpuTemp READ getCpuTemp NOTIFY cpuTempChanged FINAL)

    // getters
    double getCpuUsage() const;
    int getCpuTemp() const;


signals:
    void cpuUsageChanged();
    void cpuTempChanged();

private slots:
    void fetchCpuUsage();
    void fetchCpuTemp();

private:
    QTimer m_timer;
    double cpuUsage_ = 0.0;
    int cpuTemp_= 0;

    CpuTimes prevCpuTimes_; // var

    // return values from /proc/stat in CpuTimes struct
    CpuTimes getCpuTimes();

    // return cpu usage by comparing current and previous cpu times
    double calculateCpuUsagePercentage(const CpuTimes& prev, const CpuTimes& curr);


};

#endif // CPU_H
