#include "C++/Header/cpu.h"

// Function to check the given name starts with some prefix , "thermal_zone" in our case
bool startsWith(const std::string& str, const std::string& prefix)
{
    return str.substr(0, prefix.size()) == prefix;
}


Cpu::Cpu(QObject *parent)
    : QObject{parent}
{
    // init cpu usage and temp
    fetchCpuTemp();
    fetchCpuUsage();

    connect(&m_timer, &QTimer::timeout, this, &Cpu::fetchCpuUsage);
    connect(&m_timer, &QTimer::timeout, this, &Cpu::fetchCpuTemp);

    m_timer.start(2000);

    // init prev cpu times
    prevCpuTimes_ = getCpuTimes();
}

void Cpu::fetchCpuUsage()
{
    CpuTimes currCpuTimes = getCpuTimes();
    cpuUsage_ = calculateCpuUsagePercentage(prevCpuTimes_, currCpuTimes);
    prevCpuTimes_ = currCpuTimes;

    emit cpuUsageChanged();
}

double Cpu::calculateCpuUsagePercentage(const CpuTimes &prev, const CpuTimes &curr)
{
    /*
    calculates the difference between current and prev cpu times and return cpu
    usage.
    */
    long long prevIdle = prev.idle + prev.iowait;
    long long currIdle = curr.idle + curr.iowait;

    long long prevNonIdle = prev.user + prev.nice +
                            prev.system + prev.irq + prev.softirq + prev.steal;


    long long currNonIdle = curr.user + curr.nice +
                            curr.system + curr.irq + curr.softirq + curr.steal;

    long long prevTotal = prevIdle + prevNonIdle;
    long long currTotal = currIdle + currNonIdle;

    long long totalDiff = currTotal - prevTotal;
    long long idleDiff = currIdle - prevIdle;

    return (static_cast<double>(totalDiff - idleDiff) / totalDiff) * 100;
}

double Cpu::getCpuUsage() const
{
    // getter function for cpu_usage_
    return cpuUsage_;
}

int Cpu::getCpuTemp() const
{
    // getter function for cpu_temp_
    return cpuTemp_;
}

CpuTimes Cpu::getCpuTimes()
{
    // returns values from /proc/stat in CpuTimes struct
    std::ifstream file("/proc/stat");
    std::string line;
    CpuTimes cpuTimes = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

    if (std::getline(file, line)) {
        std::istringstream iss (line);
        std::string cpu;
        iss >> cpu >> cpuTimes.user >> cpuTimes.nice >> cpuTimes.system >>
            cpuTimes.idle >> cpuTimes.iowait >> cpuTimes.irq >> cpuTimes.softirq >>
            cpuTimes.steal >> cpuTimes.guest >> cpuTimes.guest_nice;
    }

    return cpuTimes;
}

void Cpu::fetchCpuTemp()
{
    const std::string thermalPath = "/sys/class/thermal/";
    const std::string prefix = "thermal_zone";

    DIR *dir = opendir(thermalPath.c_str());

    struct dirent* entry;
    while ((entry = readdir(dir)) != nullptr)
    {
        std::string entryName = entry->d_name;

        // check if the directory starts with "thermal_zone"
        if (startsWith(entryName, prefix))
        {

            std::string typePath = thermalPath + entryName + "/type";
            std::string tempPath = thermalPath + entryName + "/temp";

            //Read the type of the thermal zone
            std::ifstream typeFile(typePath);
            if (typeFile.is_open())
            {
                std::string type;
                std::getline(typeFile, type);
                typeFile.close();

                if (type == "x86_pkg_temp")
                {
                    // Read the tempearture and return
                    std::ifstream tempFile(tempPath);
                    double temp;
                    if(tempFile.is_open())
                    {
                        tempFile >> temp;
                        tempFile.close();
                    }

                    // convert millidegrees Celsius to degrees
                    temp /= 1000.0;
                    cpuTemp_ = temp;
                    emit cpuTempChanged();
                    return;
                }
            }
        }
    }
    cpuTemp_ = -1;
    emit cpuTempChanged();

}
