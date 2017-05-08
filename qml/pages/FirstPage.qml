/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, (DATA), OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Plats 1.0
//import "../../config.js" as DB


Page {
    id: pageListe
    /*Component.onCompleted: {
        DB.initialze()
        DB.getPlats();
    }*/

    property variant nomRegion



    SilicaListView {
        id: listView
        model: listModel

        PullDownMenu {

            MenuItem {
                text: qsTr("Ajouter Plat")
                onClicked: {
                    listModel.insertRows(0,1,parent);
                }
            }
        }



        anchors.fill: parent
        header: PageHeader {
            id : header
            title: qsTr("Plats")
        }
        delegate: ListItem {
            id: delegate
            height: 150

            function supprimerPlat(){
                remorseAction("Suppression", function() {
                    listView.model.removeRows(index,1);
                });

            }


            menu: ContextMenu {
                MenuItem {
                    text:"Supprimer"
                    onClicked: supprimerPlat();
                }
            }


            Rectangle{
                id : rectangle
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                height: 135
                radius: 15
                color: "darkBlue"



                Image {
                    id: imageQt
                    source: image
                    height: 120
                    width: 150
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                }

                Label {
                    x: Theme.paddingLarge
                    id:nomLabel
                    text:nom
                    font.pointSize: 15
                    anchors.left : imageQt.right
                    anchors.top: parent.top
                    anchors.leftMargin: 20
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Label {
                    x: Theme.paddingLarge
                    id:regionLabel
                    text:region
                    anchors.top : nomLabel.bottom
                    anchors.left : imageQt.right
                    font.pointSize: 5
                    anchors.leftMargin: 20
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Label {
                    x: Theme.paddingLarge
                    id:noteLabel
                    text:note + "/20"
                    anchors.right : parent.right
                    anchors.top : parent.top
                    font.pointSize: 5
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }

            }
            onClicked: console.log(pageStack.push(Qt.resolvedUrl("SecondPage.qml"), {plat: listModel.get(index), index : index}))//{nomPlat: nomLabel, regionPlat: regionLabel, notePlat: note, imagePath: imageQt}))//{listModel : listModel ,index : index}))



        }
        VerticalScrollDecorator {}

    }
}


