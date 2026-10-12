pragma ComponentBehavior: Bound

import QtQuick
import qs.Common
import qs.Modules.Plugins

BasePill {
    id: root
    property var widgetData: null
    property var surfaceContext: null
    enableBackgroundHover: true
    MediaActivitySource { id: source }
    content: Component {
        MediaActivityFace {
            mediaModel: source
            dense: true
            leadingInset: 0
            trailingInset: 0
            isVertical: root.isVerticalOrientation
            contentScale: root.surfaceContext?.kind === "dock" ? root.widgetThickness / 40 : Theme.barTextSize(root.barThickness, root.barConfig?.fontScale, root.barConfig?.maximizeWidgetText) / Theme.fontSizeSmall
            artworkSize: Math.min(root.widgetThickness - Theme.spacingXS * 2, Theme.iconSizeLarge * contentScale)
            enabled: root.surfaceLive
            onClockClicked: root.clicked()
        }
    }
}
