pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.Common
import qs.Modules.DBar
import qs.Modules.Plugins
import qs.DCommon.Widgets
import qs.Widgets

BasePill {
    id: root

    property var widgetData: null
    property var surfaceContext: null
    property bool compactMode: false
    readonly property bool showNotificationBadge: SettingsData.widgetOption("clock", widgetData, "clockNotificationBadge")
    readonly property int notificationCount: surfaceContext?.notificationCount ?? 0
    readonly property real textSize: Theme.barTextSize(barThickness, barConfig?.fontScale, barConfig?.maximizeWidgetText)

    SystemClock {
        id: systemClock
        enabled: root.surfaceLive && root.visible
        precision: SystemClock.Seconds
    }

    signal clockClicked

    onClicked: clockClicked()

    content: Component {
        Item {
            implicitWidth: root.isVerticalOrientation ? root.contentThickness : layout.implicitWidth
            implicitHeight: root.isVerticalOrientation ? layout.implicitHeight : root.contentThickness

            Grid {
                id: layout
                anchors.centerIn: parent
                columns: root.isVerticalOrientation ? 1 : Math.max(1, layout.visibleChildren.length)
                spacing: root.isVerticalOrientation ? Theme.spacingXXS : Theme.spacingXS
                horizontalItemAlignment: Grid.AlignHCenter
                verticalItemAlignment: Grid.AlignVCenter

                NumericText {
                    id: clock
                    isMonospace: false
                    font.features: ({"tnum": 1})
                    font.pixelSize: root.textSize
                    color: root.contentColor
                    text: systemClock.date.toLocaleDateString(I18n.locale(), "yyyy/MM/dd") + " " + systemClock.date.toLocaleTimeString(I18n.locale(), "HH:mm:ss")
                    width: Math.ceil(fixedMetrics.advanceWidth)
                    horizontalAlignment: Text.AlignHCenter

                    StyledTextMetrics {
                        id: fixedMetrics
                        font: clock.font
                        text: "8888/88/88 88:88:88"
                    }
                }

                Rectangle {
                    visible: root.showNotificationBadge && root.notificationCount > 0
                    width: Math.max(height, badgeText.implicitWidth + Theme.spacingXS * 2)
                    height: badgeText.implicitHeight + Theme.spacingXXS * 2
                    radius: Theme.fullRadius(width, height)
                    color: Theme.error

                    StyledText {
                        id: badgeText
                        anchors.centerIn: parent
                        text: root.notificationCount
                        font.pixelSize: Math.round(root.textSize * 0.75)
                        font.weight: Theme.fontWeightMedium
                        color: Theme.onError
                    }
                }
            }
        }
    }
}
