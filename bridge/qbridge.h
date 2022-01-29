#ifndef QBRIDGE_H
#define QBRIDGE_H

#include <QObject>
#include <QVariant>
#include "girls.h"
#include <QMap>
#include <QList>
#include <QQmlPropertyMap>
#include <QVariantMap>
#include <QVariantList>



class QBridge : public QObject
{
    Q_OBJECT
public:
    explicit QBridge(QObject *parent = nullptr);
public slots:
    const QVariant getGirlsList();
    int daysAlive();
};

#endif // QBRIDGE_H
