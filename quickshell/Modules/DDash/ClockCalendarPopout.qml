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
    drawBackground: false
    popupWidth: DashMetrics.preferredColumnWidth * 4
    popupHeight: DashMetrics.gridRowUnit * 4

    content: Component {
        CalendarOverviewCard {
            width: root.popupWidth
            height: root.popupHeight
            fixedOptions: ({weekends: true})
            eventEditingEnabled: false
            live: root.shouldBeVisible
        }
    }
}
