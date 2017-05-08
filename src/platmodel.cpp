#include "platmodel.h"
#include <QHash>
#include <QVariant>
#include <iostream>
#include <string>

using namespace std;

PlatModel::PlatModel(QObject *){}

QHash<int, QByteArray> PlatModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NomRole] = "nom";
    roles[RegionRole] = "region";
    roles[NoteRole] = "note";
    roles[ImageRole] = "image";
    return roles;
}

int PlatModel::rowCount(const QModelIndex &) const{
    return liste_plats.count();
}

QVariant PlatModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= liste_plats.count()){
        return QVariant();
    }

    Plat * plat = liste_plats[index.row()];

    switch (role) {
        case NomRole:
            return plat->nom();
        case RegionRole:
            return plat->region();
        case NoteRole:
            return plat->note();
        case ImageRole:
            return plat->image();
    }

    return QVariant();
}

bool PlatModel::setData(const QModelIndex &index, const QVariant &value, int role){
    if (index.row() < 0 || index.row() >= liste_plats.count())
        return false;

    if (data(index, role) == value)
        return true;

    Plat * plat = liste_plats[index.row()];
    if (role == NoteRole)
        plat->setnote(value.toInt());

    QVector<int> roles;
    roles.append(role);

    QModelIndex topLeft = index.sibling(0,0);
    QModelIndex bottomRight = index.sibling(liste_plats.count()-1, 0);

    emit dataChanged(topLeft, bottomRight, roles);

    return true;
}

void PlatModel::ajouterPlat(Plat *plat){
    beginInsertRows(QModelIndex(),rowCount(),rowCount());
    liste_plats << plat;
    endInsertRows();
}

bool PlatModel::insertRows(int row, int count, const QModelIndex &parent){
    beginInsertRows(parent, row, row+count-1);

    for (int nb = 0; nb < count; ++nb){
        liste_plats.insert(row, new Plat("Plat", "inconnu", 0, ""));
    }

    endInsertRows();
    return true;
}

//bool PlatModel::modifyRow(int row, int count, Plat *plat, const QModelIndex &parent){
bool PlatModel::modifyRow(){

   /* removeRows(row,count,parent);
    beginInsertRows(parent, row, row+count-1);
    for (int nb = 0; nb < count; ++nb){
        liste_plats.insert(row, plat);
    }
    endInsertRows();*/

    emit dataChanged(index(0),index(liste_plats.count()-1));

    //liste_plats[row]->setnom(plat->nom());
    //liste_plats[row]->setnote(plat->note());
    //setData(row,plat->nom(),0);
    //setData(row,plat->note(),2);
    return true;
}

bool PlatModel::removeRows(int row, int count, const QModelIndex &parent){
    if (row < 0 || row+count >= liste_plats.count())
        return false;

    beginRemoveRows(parent, row, row+count-1);

    for (int nb = 0; nb < count; ++nb){
        liste_plats.removeAt(row);
    }

    endRemoveRows();
    return true;
}


Plat *PlatModel::get(int index){
    //cout << liste_plats.at(index)->nom();
    return liste_plats.at(index);
}

