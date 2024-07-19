#include "gpu.h"

/* function to execute shell commands*/
std::string exec(const char* cmd)
{
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);

    if(!pipe)
    {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr)
    {
        result += buffer.data();
    }
    return result;
}

Gpu::Gpu(QObject *parent)
    : QObject{parent}
{
    // init fetching gpu temp and usage
    fetchGpuTemp();
    fetchGpuUsage();

    // Intialize timer to fetch data every 2 seconds
    connect(&m_timer, &QTimer::timeout, this, &Gpu::fetchGpuUsage);
    connect(&m_timer, &QTimer::timeout, this, &Gpu::fetchGpuTemp);
    m_timer.start(2000);
}

double Gpu::getGpuUsage() const
{
    // getter function for gpu usage
    return gpuUsage_;
}

int Gpu::getGpuTemp() const
{
    // getter function for gpu temperature
    return gpuTemp_;
}

void Gpu::fetchGpuUsage()
{
    const char* usageCommand = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader";
    gpuUsage_ = std::stoi(exec(usageCommand));
    emit gpuUsageChanged();
}

void Gpu::fetchGpuTemp()
{
    const char* tempCommand = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader";
    gpuTemp_ = std::stoi(exec(tempCommand));
    emit gpuTempChanged();
}

