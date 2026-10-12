pragma ComponentBehavior: Bound

import QtQuick
import qs.Common
import qs.Modules.DBar
import qs.Modules.SurfaceWidgets

Item {
    id: root
    required property var controller
    required property var systemModel
    readonly property bool vertical: controller.isVertical
    readonly property var entries: (controller.barConfig?.centerWidgets ?? []).map((entry, index) => {
        const data = typeof entry === "string" ? {id: entry} : entry;
        return Object.assign({}, data, {
            id: "island-center-" + index + "-" + data.id,
            widgetId: data.id
        });
    })

    SurfaceContext {
        id: context
        host: root.controller.barBody
        config: root.controller.barConfig
        screen: root.controller.screen
        kind: "bar"
    }

    SurfaceWidgetFactory {
        id: factory
        surfaceContext: context
    }

    SurfaceStrip {
        id: strip
        anchors.centerIn: parent
        width: root.vertical ? context.thickness : implicitWidth
        height: root.vertical ? implicitHeight : context.thickness
        availableSize: root.vertical ? height : width
        spacing: BarMetrics.widgetSpacing(context.config, context.config?.noBackground ?? false,
                                         (context.config?.widgetOutlineEnabled ?? false) ? (context.config?.widgetOutlineThickness ?? Theme.outlineWidth) : 0)
        surfaceContext: context
        components: factory.componentMap
        model: root.entries
        onImplicitWidthChanged: root.measure()
        onImplicitHeightChanged: root.measure()
    }

    function measure() {
        controller.setHomeContentLength(root.vertical ? strip.implicitHeight : strip.implicitWidth);
    }
    onVerticalChanged: measure()
    Component.onCompleted: measure()
}
