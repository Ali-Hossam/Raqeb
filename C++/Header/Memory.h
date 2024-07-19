#ifndef MEMORY_H
#define MEMORY_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <iostream>
#include <fstream>
#include <sstream>
#include <unordered_map>
#include <string>



class Memory : public QObject
{
    Q_OBJECT
public:
    explicit Memory(QObject *parent = nullptr);

    Q_PROPERTY(double memUsage READ getMemUsage NOTIFY memUsageChanged FINAL)

    // getters
    double getMemUsage() const;

signals:
    // signal functions to emit variable change signal to qml
    void memUsageChanged();

private slots:
    void fetchMemUsage();

private:
    QTimer m_timer;
    double memUsage_ = 0.0;

    // extract data from /proc/meminfo and add it to a map
    std::unordered_map<std::string, long long> parseMemInfo();

};

#endif // MEMORY_H
