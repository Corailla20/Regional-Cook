#ifndef PLATMODEL_H
#define PLATMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QHash>
#include <QList>
#include "plat.h"

class PlatModel: public QAbstractListModel
{
    Q_OBJECT
public:

    enum PlatRoles {
        NomRole = 0,
        RegionRole = 1,
        NoteRole = 2,
        ImageRole = 3
    };

    PlatModel(QObject *parent = 0);
    void ajouterPlat(Plat *plat);
    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    Q_INVOKABLE QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::DisplayRole);

    Q_INVOKABLE bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex());
    Q_INVOKABLE bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex());
    Q_INVOKABLE bool modifyRow();
    Q_INVOKABLE Plat* get(int index);


 protected:
    QHash<int, QByteArray>roleNames() const;

 private :
    QList<Plat*> liste_plats;


};

#endif // PLATMODEL_H
