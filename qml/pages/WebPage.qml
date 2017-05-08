import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0

Page {
    property variant nomPlat;
    Rectangle {
        anchors.fill: parent

        WebView {
            id: webview

            url: "http://m.marmiton.org/recettes/recherche.aspx?aqt=" + nomPlat
            anchors.fill: parent
        }
    }
}
