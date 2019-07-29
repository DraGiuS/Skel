/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5

Rectangle {
    id: root
       Image {
            source: "images/Helium_Wallpaper_1920x1200_130_70"


 
        }
    
    property int stage
    FontLoader { id: webFont; source: "fonts/OpenSans-Light.ttf" }

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
            preOpacityAnimation.from = 0;
            preOpacityAnimation.to = 1;
            preOpacityAnimation.running = true;
        }
        if (stage == 4) {
            preOpacityAnimation.from = 1;
            preOpacityAnimation.to = 0;
            preOpacityAnimation.running = true;
            pausa.start();
        }
    }

    Item {
        id: content
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        opacity: 1
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            property real size: units.gridUnit * 8
            anchors.centerIn: parent
            source: "images/plasma.svgz"
            sourceSize.width: size
            sourceSize.height: size
        }
    }

    Image {
        id: topRect
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height
        source: "images/rectangl.svg"
        Rectangle {
            y: 232
            radius: 0
            anchors.horizontalCenterOffset: 0
            color: "#bfc0c1"
            anchors {
                bottom: parent.bottom
                bottomMargin: 50
                horizontalCenter: parent.horizontalCenter
            }
            height: 4
            width: height*50
            Rectangle {
                id: topRectRectangle
                radius: 0
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: (parent.width / 6) * (stage - 1)
                color: "#009bff"
                Behavior on width {
                    PropertyAnimation {
                        duration: 250
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }

    SequentialAnimation {
        id: introAnimation
        running: false

        ParallelAnimation {
            PropertyAnimation {
                property: "y"
                target: topRect
                to: ((root.height / 3) * 2) - 170
                duration: 2000
                easing.type: Easing.InOutBack
                easing.overshoot: 1.0
            }
            
        }
    }

    Text {
        id: preLoadingText
        height: 30
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        text: "Hi there, welcome back!"
        color: "#202020"
        font.family: webFont.name
        font.weight: Font.ExtraLight

        font.pointSize: 20
        opacity: 0
        textFormat: Text.StyledText
        x: (root.width - width) / 2
        y: (root.height / 3) * 2
    }
    
    OpacityAnimator {
        id: preOpacityAnimation
        running: false
        target: preLoadingText
        from: 0
        to: 1
        duration: 1500
        easing.type: Easing.InOutQuad
    }
    
    Text {
        id: loadingText
        height: 30
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        text: "Preparing your desktop..."
        color: "#202020"
        font.family: webFont.name
        font.weight: Font.ExtraLight

        font.pointSize: 20
        opacity: 0
        textFormat: Text.StyledText
        x: (root.width - width) / 2
        y: (root.height / 3) * 2
    }

    OpacityAnimator {
        id: opacityAnimation
        running: false
        target: loadingText
        from: 0
        to: 1
        duration: 1500
        easing.type: Easing.InOutQuad
        paused: true
    }

    Timer {
        id: pausa
        interval: 1500; running: false; repeat: false;
        onTriggered: root.viewLoadingText();
    }

    function viewLoadingText() {
        opacityAnimation.from = 0;
        opacityAnimation.to = 1;
        opacityAnimation.running = true;
    }

}
