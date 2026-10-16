import QtQuick
import qs.Common
import qs.Modules.Notifications
import qs.Modules.Plugins
import qs.DCommon.Widgets

BasePill {
    id: root
    circular: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
    onMiddleClicked: SessionData.setDoNotDisturb(!SessionData.doNotDisturb)

    property bool hasUnread: false
    property bool isActive: false

    content: Component {
        Item {
            implicitWidth: notifIcon.width
            implicitHeight: root.contentThickness

            DIcon {
                id: notifIcon
                anchors.centerIn: parent
                name: SessionData.doNotDisturb ? "notifications_off" : "notifications"
                size: Theme.barIconSize(root.barThickness, -Theme.spacingXS, root.barConfig?.maximizeWidgetIcons, root.barConfig?.iconScale)
                color: SessionData.doNotDisturb ? Theme.primary : (root.isActive ? Theme.primary : Theme.widgetIconColor)
            }

            Rectangle {
                width: NotificationMetrics.unreadDotSize
                height: width
                radius: width / 2
                color: Theme.error
                anchors.right: notifIcon.right
                anchors.top: notifIcon.top
                visible: root.hasUnread
            }
        }
    }

}
