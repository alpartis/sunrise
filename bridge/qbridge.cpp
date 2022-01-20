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
    const int limit = int(girls.size());
    m_girllist.clear();
    for(int i=0; i<limit; i++)
    {
        const QString & first_name = QString::fromStdString(girls[i].first_name);
        const QString & last_name = QString::fromStdString(girls[i].last_name);
        QMap<QString,QString> item;
        item.insert("first_name",first_name);
        item.insert("last_name",last_name);
        m_girllist.append(item);
    }

    return QVariant::fromValue(m_girllist);
}
