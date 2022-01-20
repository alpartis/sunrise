#ifndef QBRIDGE_H
#define QBRIDGE_H

#include <QObject>
#include <QVariant>
#include "girls.h"
#include <QMap>
#include <QList>



class QBridge : public QObject
{
    Q_OBJECT
    QList<QMap<QString,QString>> m_girllist;
public:
    explicit QBridge(QObject *parent = nullptr);
public slots:
    Q_INVOKABLE const QVariant getGirlsList();
};

#endif // QBRIDGE_H
