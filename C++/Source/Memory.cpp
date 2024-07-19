#include "Memory.h"

// Class constructor
Memory::Memory(QObject *parent)
    : QObject{parent}
{
    // init memory usage fetching function
    fetchMemUsage();

    // Intialize timer to fetch data every 2 seconds
    connect(&m_timer, &QTimer::timeout, this, &Memory::fetchMemUsage);
    m_timer.start(2000);
}


void Memory::fetchMemUsage()
{
    auto memInfo = Memory::parseMemInfo();

    // calculate available memory (similar to the one in free command)
    long long totalMem = memInfo["MemTotal"];
    long long freeMem = memInfo["MemFree"];
    long long active = memInfo["Active(file)"];
    long long inActive = memInfo["Inactive(file)"];
    long long sReclaimable = memInfo["SReclaimable"];

    // used memory: total memory - free memory - buffers - cached
    long long usedMem = totalMem - freeMem - active - inActive - sReclaimable;

    // calculate the percentage of used memory
    double usedPercentage = (static_cast<double>(usedMem) / totalMem) * 100;

    memUsage_ = usedPercentage;
    emit memUsageChanged();
}


double Memory::getMemUsage() const
{
    // getter function for memUsage_ var
    return memUsage_;
}


std::unordered_map<std::string, long long> Memory::parseMemInfo() {
    std::unordered_map<std::string, long long> memInfo;
    std::ifstream memData("/proc/meminfo");
    std::string line;

    // extract data from /proc/meminfo and add it to a map
    while (std::getline(memData, line)) {
        std::istringstream iss(line);
        std::string key;
        long long value;
        std::string unit;
        iss >> key >> value >> unit;

        // remove trailing colon from the key
        key = key.substr(0, key.size() - 1);
        memInfo[key] = value;
    }
    return memInfo;
}

