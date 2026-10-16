pragma ComponentBehavior: Bound

import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.DDash.Overview

DPopout {
    id: root
    property var triggerScreen: null
    screen: triggerScreen
    layerNamespace: "dms:clock-calendar"
    popupWidth: DashMetrics.preferredColumnWidth * 4
    popupHeight: DashMetrics.gridRowUnit * 4

    content: Component {
        CalendarOverviewCard {
            width: root.popupWidth
            height: root.popupHeight
            color: "transparent"
            border.width: 0
            fixedOptions: ({weekends: true})
            eventEditingEnabled: false
            live: root.shouldBeVisible
        }
    }
}
