#include "plat.h"

Plat::Plat(const QString &nom, const QString &region, const int &note, const QString &image)
            :m_nom(nom), m_region(region), m_note(note), m_image(image)
{

}

QString Plat::nom() const
{
    return m_nom;
}

QString Plat::region() const
{
    return m_region;
}

int Plat::note() const
{
    return m_note;
}


QString Plat::image() const
{
    return m_image;
}

void Plat::setnom(QString arg)
{
    if (m_nom != arg){
        m_nom = arg;
        emit nomChanged(arg);
    }
}

void Plat::setregion(QString arg)
{
    if (m_region != arg){
        m_region = arg;
        emit regionChanged(arg);
    }
}

void Plat::setimage(QString arg)
{
    if (m_image != arg){
        m_image = arg;
        emit imageChanged(arg);
    }
}

void Plat::setnote(int arg)
{
    if (m_note != arg){
        m_note = arg;
        emit noteChanged(arg);
    }
}


