#include "favoritegirlmodel.h"
#include <QDebug>

FavoriteGirlModel::FavoriteGirlModel(QObject * parent):QAbstractListModel(parent)
{

}

int FavoriteGirlModel::rowCount(const QModelIndex &parent = QModelIndex()) const
{
    qDebug()<<parent<<endl;
    return mDatas.size();
}

void FavoriteGirlModel::addFavoriteGirl(const FavoriteGirl &item)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    mDatas << item;
    endInsertRows();
}

QVariant FavoriteGirlModel::data(const QModelIndex &index, int role) const
{
 if (!index.isValid())
       return QVariant();

    if (index.row() < 0 || index.row() >= mDatas.count())
        return QVariant();

   if ( role == FirstNameRole)
   {
       if ( index.column() == 0)
       {
           return mDatas[index.row()].firstName();
       }
   }
   if ( role == LastNameRole)
   {
       if ( index.column() == 0)
       {
           return mDatas[index.row()].lastName();
       }
   }
   return QVariant();
}

QHash<int, QByteArray> FavoriteGirlModel::roleNames() const
{
  QHash<int, QByteArray> roles;
    roles[FirstNameRole] = "first_name";
    roles[LastNameRole] = "last_name";
    return roles;
}

FavoriteGirl::FavoriteGirl(const QString &first_name, const QString &last_name)
    :m_first_name(first_name)
    ,m_last_name(last_name)
{
}
