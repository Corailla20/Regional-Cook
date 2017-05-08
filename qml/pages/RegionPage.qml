import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: regionListe
    SilicaListView {
        id: listView
        model: ListModel {
            ListElement { name: "Auvergne"; icon :""}
            ListElement { name: "Picardie"; icon :""}
            ListElement { name: "Nord-Pas-de-Calais"; icon :""}
            ListElement { name: "Alsace"; icon :""}
            ListElement { name: "Basse-Normandie"; icon :""}
            ListElement { name: "Haute-Normadie"; icon :""}
            ListElement { name: "Languedoc Rousilon"; icon :""}
            ListElement { name: "Bretagne"; icon :""}
            ListElement { name: "Centre"; icon :""}
            ListElement { name: "Limousin"; icon :""}
            ListElement { name: "Provence Alpes Côtes Azure"; icon :""}
            ListElement { name: "Franche-Comté"; icon :""}
            ListElement { name: "Aquitaine"; icon :""}
            ListElement { name: "Rhônes-Alpes"; icon :""}
            ListElement { name: "Bourgogne"; icon :""}
            ListElement { name: "Île-de-France"; icon :""}
            ListElement { name: "Champagne-Ardenne"; icon :""}
            ListElement { name: "Midi Pyrennées"; icon :""}
            ListElement { name: "Pays de la Loire"; icon :""}
            ListElement { name: "Corse"; icon :""}
            ListElement { name: "Poitou Charentes"; icon :""}
            ListElement { name: "Lorraine"; icon :""}

        }

        anchors.fill: parent

        delegate: ListItem {
            id: delegate

            Label {
                id:nomRegion
                text:name
                font.pointSize: 15
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            onClicked: console.log(pageStack.push(Qt.resolvedUrl("FirstPage.qml"), {nomRegion : nomRegion.text}))
        }
    }

}

