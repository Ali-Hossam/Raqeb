#ifndef GPU_H
#define GPU_H

#include <QObject>
#include <QTimer>
#include <QDebug>

class Gpu : public QObject
{
    Q_OBJECT
public:
    explicit Gpu(QObject *parent = nullptr);

    Q_PROPERTY(double gpuUsage READ getGpuUsage NOTIFY gpuUsageChanged FINAL)
    Q_PROPERTY(int gpuTemp READ getGpuTemp NOTIFY gpuTempChanged FINAL)

    // getters
    double getGpuUsage() const;
    int getGpuTemp() const;


signals:
    void gpuUsageChanged();
    void gpuTempChanged();

private slots:
    void fetchGpuUsage();
    void fetchGpuTemp();

private:
    QTimer m_timer;
    double gpuUsage_ = 0.0;
    int gpuTemp_ = 0;

};

#endif // GPU_H
