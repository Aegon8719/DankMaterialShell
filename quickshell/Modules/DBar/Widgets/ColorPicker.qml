import QtQuick
import qs.Common
import qs.Modules.Plugins
import qs.DCommon.Widgets

BasePill {
    id: root

    property bool isActive: false

    signal colorPickerRequested

    content: Component {
        Item {
            implicitWidth: icon.width
            implicitHeight: root.contentThickness

            DIcon {
                id: icon
                anchors.centerIn: parent
                name: "palette"
                size: Theme.barIconSize(root.barThickness, -4, root.barConfig?.maximizeWidgetIcons, root.barConfig?.iconScale)
                color: root.isActive ? Theme.primary : Theme.surfaceText
            }
        }
    }

    onClicked: colorPickerRequested()
}
