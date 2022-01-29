#include "qbridge.h"
#include <QVariant>
#include <QDate>

extern std::vector<Girl> girls;

QBridge::QBridge(QObject *parent)
    : QObject{parent}
{
    girls.push_back(Girl{"Amy","Bredwell"});
    girls.push_back(Girl{"Ruby","Sherwood"});
}

/******************************************************************************
* returns number of days between 'now' and "hypothetical" Nov 1, 1965 birthday
******************************************************************************/
int QBridge::daysAlive()
{
    QDate dob(1965, 11, 1);
    return dob.daysTo(QDate::currentDate());
}


const QVariant QBridge::getGirlsList()
{

    QVariantList list;
    const int limit = int(girls.size());
    for(int i=0; i<limit; i++)
    {
        const QString & first_name = QString::fromStdString(girls[i].first_name);
        const QString & last_name = QString::fromStdString(girls[i].last_name);
        QVariantMap item;
        item.insert("first_name",first_name);
        item.insert("last_name",last_name);
        list.append(QVariant::fromValue(item));
    }


    return QVariant::fromValue(list);
}
