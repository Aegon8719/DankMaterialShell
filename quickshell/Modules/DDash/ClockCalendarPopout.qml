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
    popupWidth: DashMetrics.preferredColumnWidth * 4 + Theme.spacingM * 2
    popupHeight: DashMetrics.gridRowUnit * 4 + Theme.spacingM * 2

    content: Component {
        Column {
            width: root.popupWidth
            padding: Theme.spacingM
            spacing: Theme.spacingM

            CalendarOverviewCard {
                width: parent.width - Theme.spacingM * 2
                height: DashMetrics.gridRowUnit * 4
                fixedOptions: ({weekends: true})
                eventEditingEnabled: false
                live: root.shouldBeVisible
            }
        }
    }
}
