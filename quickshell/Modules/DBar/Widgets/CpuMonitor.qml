import qs.Services
import qs.Common

MonitorPill {
    id: root

    signal cpuClicked

    readonly property real usage: DgopService.cpuUsage
    readonly property bool combinedMemory: widgetData?.combinedMemory ?? false
    readonly property string cpuText: usage.toFixed(0) + "%"
    readonly property string memoryText: DgopService.memoryUsage.toFixed(0) + "%"

    widgetType: "cpuUsage"
    dgopModules: combinedMemory ? ["cpu", "memory"] : ["cpu"]
    iconName: "memory"
    showIcon: false
    level: usage
    warnLevel: 60
    dangerLevel: 80
    verticalText: usage ? usage.toFixed(0) : "--"
    verticalSecondaryText: combinedMemory ? memoryText : ""
    horizontalText: combinedMemory ? I18n.tr("CPU") + " " + cpuText + "  " + I18n.tr("RAM") + " " + memoryText : usage ? cpuText : "--%"
    reserveText: combinedMemory ? I18n.tr("CPU") + " 100%  " + I18n.tr("RAM") + " 100%" : "100%"
    sortKey: "cpu"
    onActivated: cpuClicked()
}
