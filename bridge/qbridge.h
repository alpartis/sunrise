#ifndef QBRIDGE_H
#define QBRIDGE_H

#include <QObject>
#include <QVariant>
#include "girls.h"
#include <QMap>
#include <QList>
#include <QQmlPropertyMap>



class QBridge : public QObject
{
    Q_OBJECT
    QList<QQmlPropertyMap*> m_girllist;
public:
    explicit QBridge(QObject *parent = nullptr);
public slots:
    Q_INVOKABLE const QVariant getGirlsList();
};

#endif // QBRIDGE_H
