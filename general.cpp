#include "general.h"

void show_thread()
{

    QThread *ptr = QThread::currentThread();
    qDebug() << "Thread Name" << ptr->objectName();
    qDebug() << "Thread Id" << QThread::currentThreadId()<<endl;
}

void set_thread_name(const QString name)
{
    QThread::currentThread()->setObjectName(name);
}