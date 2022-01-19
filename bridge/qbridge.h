#ifndef QBRIDGE_H
#define QBRIDGE_H

#include <QObject>
#include <QVariant>
#include "girls.h"

class DataObject : public QObject
{
    Q_OBJECT
    QString m_first_name;
    QString m_last_name;
    Q_PROPERTY(QString first_name READ first_name WRITE setName CONSTANT)
    Q_PROPERTY(QString last_name READ last_name WRITE setLastName CONSTANT)
public:
    explicit DataObject(QString first_name, QString last_name, QObject * parent=nullptr):
        QObject(parent),
        m_first_name(first_name),
        m_last_name(last_name)
    {

    }

    void setName(QString name)
    {
        m_first_name = name;
    }

    void setLastName(QString name)
    {
        m_last_name = name;
    }

    const QString first_name()
    {
        return m_first_name;
    }

    const QString last_name()
    {
        return m_last_name;
    }

};

class QBridge : public QObject
{
    Q_OBJECT
public:
    explicit QBridge(QObject *parent = nullptr);
public slots:
    Q_INVOKABLE const QVariant getGirlsList();
};

#endif // QBRIDGE_H
