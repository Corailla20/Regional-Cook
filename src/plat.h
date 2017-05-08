#ifndef PLAT_H
#define PLAT_H

#include <QObject>

class Plat : public QObject
{
    Q_OBJECT
public :
    Plat(const QString &nom = "Sans nom", const QString &region = "M",const int &note = 20, const QString &image = "../tartiflette.jpg");

    Q_PROPERTY(QString nom READ nom WRITE setnom NOTIFY nomChanged)
    Q_PROPERTY(QString region READ region WRITE setregion NOTIFY regionChanged)
    Q_PROPERTY(QString image READ image WRITE setimage NOTIFY imageChanged)
    Q_PROPERTY(int note READ note WRITE setnote NOTIFY noteChanged)

    QString nom() const;
    QString region() const;
    int note() const;
    QString image() const;

public slots:
    void setnom(QString arg);
    void setregion(QString arg);
    void setimage(QString arg);
    void setnote(int arg);

signals:
    void nomChanged(QString arg);
    void regionChanged(QString arg);
    void imageChanged(QString arg);
    void noteChanged(int arg);

private:
    QString m_nom;
    QString m_region;
    int m_note;
    QString m_image;

};

#endif // PLAT_H
