#ifndef INTERFACENAMEDPIPE_H
#define INTERFACENAMEDPIPE_H

#include<QString>

class InterfaceNamedPipe
{
public:
    virtual void setName(const QString name) = 0;
    virtual bool create() = 0;
    virtual bool isExist() = 0;
    virtual QString pipeRead() = 0;
    virtual void pipeWrite(const QString line) = 0;
    virtual bool deletePipe(void) = 0;
    virtual ~InterfaceNamedPipe(){}
};

#endif // INTERFACENAMEDPIPE_H
