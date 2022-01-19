#include "qbridge.h"
#include <QVariant>

extern std::vector<Girl> girls;

QBridge::QBridge(QObject *parent)
    : QObject{parent}
{
    girls.push_back(Girl{"Amy","Bredwell"});
    girls.push_back(Girl{"Ruby","Sherwood"});
}

const QVariant QBridge::getGirlsList()
{
    QList<QObject *> datalist;
    const int limit = int(girls.size());
    for(int i=0; i<limit; i++)
    {
        const QString & first_name = QString::fromStdString(girls[i].first_name);
        const QString & last_name = QString::fromStdString(girls[i].last_name);
        QObject * item = new DataObject(first_name,last_name);
        datalist.append(item);
    }

    return QVariant::fromValue(datalist);
}
