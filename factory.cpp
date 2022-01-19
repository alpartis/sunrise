#include "factory.h"
#ifdef __linux__
#include "linuxnamedpipe.h"
#elif _WIN32
#else
#endif

Factory::Factory(QObject *parent)
    : QObject{parent}
{
}

InterfaceNamedPipe *Factory::createNamedPipeObject(QString file_name)
{
    InterfaceNamedPipe *ptr = nullptr;
#ifdef __linux__
    ptr = new LinuxNamedPipe(file_name);
#elif _WIN32
#else
#endif
    return ptr;
}
