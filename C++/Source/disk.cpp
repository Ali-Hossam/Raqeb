#include "C++/Header/disk.h"
#include <sys/statvfs.h>

Disk::Disk(QObject *parent)
    : QObject{parent}
{
    // init disk usage
    fetchDiskUsage();

    connect(&m_timer, &QTimer::timeout, this, &Disk::fetchDiskUsage);
    m_timer.start(20000);
}

void Disk::fetchDiskUsage()
{
    /*
    returns root disk (/) usage
    */
    struct statvfs buf;

    // path to the filesystem we want to check (root filesystem)
    const char* path = "/";

    if (statvfs(path, &buf) == 0) {
        // Total size of the filesystem in bytes
        long long totalSize = buf.f_blocks * buf.f_frsize;

        // Total available space in bytes
        long long available = buf.f_bavail * buf.f_frsize;

        // Total used space in bytes
        long long used = totalSize - available;

        diskUsage_ = (static_cast<double>(used) / totalSize) * 100;
        emit diskUsageChanged();
    }
}

double Disk::getDiskUsage() const
{
    // getter function for diskUsage_
    return diskUsage_;
}
