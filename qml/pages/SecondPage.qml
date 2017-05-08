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
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Plats 1.0
import QtSensors 5.1
import QtMultimedia 5.0

Page {
    id: page
    //property ListModel listModel
    property int index
    property variant plat
    //property Text nomPlat
    //property Text regionPlat
    //property int notePlat
    //property Text imagePath


    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Back")
                onClicked: pageStack.pop()
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: page.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        /*Item {
            id: plat
            property string nomP: nomPlat.text//listModel.data(index,0)
            property string regionP: regionPlat.text//listModel.data(index,1)
            property int note : slider.value
        }*/




        Image {
            id: image
            source: plat.image//listModel.get(index).image
            height: 300
            width: 450
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20
            anchors.leftMargin: 15

            MouseArea {
                anchors.fill: parent
                onPressed: image.state = "PRESSED"
                onReleased: image.state = "RELEASED"
            }

            states: [
                State {
                    name: "PRESSED"
                    PropertyChanges { target: image; source: "../wow.jpg"}
                },
                State {
                    name: "RELEASED"
                    PropertyChanges { target: image; source: plat.image}
                }
            ]

            transitions: [
                Transition {
                    from: "PRESSED"
                    to: "RELEASED"
                    ColorAnimation { target: image; duration: 200}
                },
                Transition {
                    from: "RELEASED"
                    to: "PRESSED"
                    ColorAnimation { target: image; duration: 200}
                }
            ]

        }

        TextEdit {
            id: nom2
            text: plat.nom///*nomPlat.text*/listModel.data(index,0)//listModel.data(1, 0)
            color: "red"
            anchors.top : image.bottom
            anchors.topMargin: 20
            font.pointSize: 50
            onTextChanged: {
                console.log("TextEdit");
                plat.setnom(nom2.text);
                listModel.modifyRow();
            }
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Column{
            id : colonne
            anchors.top: nom2.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 20
            anchors.leftMargin: 15
            anchors.rightMargin: 15

            Label {
                id: region
                text: "Région : " + plat.region // + listModel.get(index).region
            }

            Label {
                id: note
                text: "Note : " + plat.note + "/20" //"Note : " + listModel.get(index).note + "/20"
            }

            Slider {
                id : slider
                anchors.left: parent.left
                anchors.right: parent.right
                maximumValue: 20
                minimumValue: 0
                value : plat.note //listModel.data(index, 2)
                onSliderValueChanged: {
                    console.log("Slider");
                    plat.setnote(slider.value);
                    listModel.modifyRow();
                }

                //listModel.data(index, 2).note = slider.value
                stepSize: 0.5
            }

            Row {
                anchors.bottomMargin: 20
                spacing : 30
                Button{
                    id: buttonWeb
                    text: "Voir la recette"
                    onClicked: {

                        console.log(pageStack.push(Qt.resolvedUrl("WebPage.qml"), {nomPlat: plat.nom}));
                    }
                }

                Button {
                    id: buttonAnim
                    text: "Animation"
                    state: "RELEASED"

                    MouseArea {
                        anchors.fill: parent
                        onPressed: buttonAnim.state = "PRESSED"
                        onReleased: buttonAnim.state = "RELEASED"
                    }

                    states: [
                        State {
                            name: "PRESSED"
                            PropertyChanges { target: buttonAnim; color: "lightblue"}
                        },
                        State {
                            name: "RELEASED"
                            PropertyChanges { target: buttonAnim; color: "red"}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "PRESSED"
                            to: "RELEASED"
                            ColorAnimation { target: buttonAnim; duration: 500}
                        },
                        Transition {
                            from: "RELEASED"
                            to: "PRESSED"
                            ColorAnimation { target: buttonAnim; duration: 500}
                        }
                    ]
                }
            }

            Accelerometer {
                id: accel
                active: true
                accelerationMode: Accelerometer.User

                onReadingChanged: {
                    if(reading.x > 15){
                        onClicked: pageStack.pop()
                    }
                }
            }

            Rectangle {

                width : 446
                height : 250
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                color : "grey"


                /*Video {
                    id : video
                    width : parent.width
                    height : parent.height
                    source : "../video"+plat.nom+".mp4"


                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(video.playbackState == MediaPlayer.PlayingState){
                                video.pause();
                            }

                            else
                                video.play();
                        }
                    }

                    focus : true
                }*/
            }


        }
    }
}




