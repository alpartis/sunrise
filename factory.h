#ifndef FACTORY_H
#define FACTORY_H

#include <QObject>
#include <interfacenamedpipe.h>

class Factory : public QObject
{
    Q_OBJECT
public:
    explicit Factory(QObject *parent = nullptr);
    static InterfaceNamedPipe * createNamedPipeObject(QString file_name);

signals:

};

#endif // FACTORY_H
