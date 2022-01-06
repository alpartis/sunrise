#include "linuxnamedpipe.h"
#include <QStringList>

LinuxNamedPipe::LinuxNamedPipe(QString pipe_name) : m_pipe_name(pipe_name.toLocal8Bit())
{
}

void LinuxNamedPipe::setName(const QString name)
{
    this->m_pipe_name = name.toLocal8Bit();
}

bool LinuxNamedPipe::create()
{
    const char *myfifo = this->m_pipe_name.data();
    mkfifo(myfifo, 0666);
    return true;
}

bool LinuxNamedPipe::isExist()
{
    const char *fname = m_pipe_name.data();
    if (access(fname, F_OK) == 0)
    {
        return true;
    }

    return false;
}

QString LinuxNamedPipe::pipeRead()
{

    const char *fname = m_pipe_name.data();
    char arr[254];

    int fd;
    fd = open(fname, O_RDONLY);
    int result = read(fd, arr, sizeof(arr));
    close(fd);
    QString line;
    line = QString::fromUtf8(arr, sizeof(arr)).split("\n").at(0).trimmed();
    return line;
}

void LinuxNamedPipe::pipeWrite(const QString line)
{

    int fd;
    const char *fname = m_pipe_name.data();
    const QByteArray ba_line = line.toUtf8();
    const char *data = ba_line.data();

    fd = open(fname, O_WRONLY);
    write(fd, data, ba_line.size());
    close(fd);
}

bool LinuxNamedPipe::deletePipe()
{
    if (!this->isExist())
    {
        return false;
    }

    const char *fname = m_pipe_name.data();
    if (remove(fname) == 0)
    {
        return true;
    }
    return false;
}
