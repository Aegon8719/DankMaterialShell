import QtQuick
import qs.Common
import qs.DCommon.Widgets

Rectangle {
    id: root

    property string iconName: ""
    property string title: ""
    property string description: ""
    property bool vertical: false
    property real iconContainerSize: Math.round(Theme.iconSize * 1.5)
    property real iconSize: Theme.iconSize - Theme.spacingXS
    property real contentSpacing: Theme.spacingS
    property color iconBackground: Theme.primaryContainer
    property color iconColor: Theme.accentOnPrimaryContainer

    signal clicked

    radius: Theme.cornerRadius
    color: Theme.floatingWindowNestedSurface
    border.width: Theme.layerOutlineWidth
    border.color: Theme.outlineMedium

    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: Theme.primary
        opacity: mouseArea.containsMouse ? 0.12 : 0
    }

    Grid {
        id: layout
        anchors.centerIn: parent
        width: root.vertical ? implicitWidth : parent.width - Theme.spacingM * 2
        columns: root.vertical ? 1 : 2
        spacing: root.contentSpacing
        horizontalItemAlignment: root.vertical ? Grid.AlignHCenter : Grid.AlignLeft
        verticalItemAlignment: Grid.AlignVCenter

        Rectangle {
            width: root.iconContainerSize
            height: width
            radius: Math.round(width * 0.28)
            color: root.iconBackground

            DIcon {
                anchors.centerIn: parent
                name: root.iconName
                size: root.iconSize
                color: root.iconColor
            }
        }

        Column {
            width: root.vertical ? implicitWidth : layout.width - root.iconContainerSize - layout.spacing
            spacing: Theme.spacingXXS

            StyledText {
                text: root.title
                font.pixelSize: Theme.fontSizeSmall
                font.weight: Theme.fontWeightMedium
                color: Theme.surfaceText
                anchors.horizontalCenter: root.vertical ? parent.horizontalCenter : undefined
            }

            StyledText {
                text: root.description
                font.pixelSize: Theme.fontSizeSmall - 1
                color: Theme.surfaceVariantText
                width: root.vertical ? implicitWidth : parent.width
                elide: root.vertical ? Text.ElideNone : Text.ElideRight
                anchors.horizontalCenter: root.vertical ? parent.horizontalCenter : undefined
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
