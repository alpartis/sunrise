#ifndef FAVORITEGIRLMODEL_H
#define FAVORITEGIRLMODEL_H

#include <QAbstractListModel>
#include <QObject>

class FavoriteGirl
{
    QString m_first_name;
    QString m_last_name;
public:
    FavoriteGirl(const QString &first_name, const QString &last_name);
    const QString firstName() const{return m_first_name;}
    const QString lastName() const{return m_last_name;}
};

class FavoriteGirlModel : public QAbstractListModel
{
    Q_OBJECT
    QList<FavoriteGirl> mDatas;

public:
    FavoriteGirlModel(QObject *parent=nullptr);
    enum FavoriteGirlRoles {
        FirstNameRole = Qt::UserRole + 1,
        LastNameRole
    };
    int rowCount(const QModelIndex &parent) const;
    void addFavoriteGirl(const FavoriteGirl &item);
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int,QByteArray> roleNames() const;
};

#endif // FAVORITEGIRLMODEL_H
