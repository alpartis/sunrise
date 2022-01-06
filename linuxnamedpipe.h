#ifndef LINUXNAMEDPIPE_H
#define LINUXNAMEDPIPE_H

#include "interfacenamedpipe.h"
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/select.h>

class LinuxNamedPipe : public InterfaceNamedPipe
{
    //QString m_pipe_name;
    QByteArray m_pipe_name;
public:
    LinuxNamedPipe(QString pip_name);
    void setName(const QString name);
    bool create();
    bool isExist();
    QString pipeRead();
    void pipeWrite(const QString line);
    bool deletePipe();
};

#endif // LINUXNAMEDPIPE_H
