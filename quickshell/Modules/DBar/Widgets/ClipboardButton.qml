import QtQuick
import qs.Common
import qs.Modules.Plugins
import qs.Services
import qs.DCommon.Widgets
import qs.Widgets

BasePill {
    id: root
    circular: true

    property bool isActive: false
    property bool dropConfirmed: false

    signal clipboardClicked
    signal showSavedItemsRequested
    signal clearAllRequested

    onClicked: clipboardClicked()
    onRightClicked: (rootX, rootY) => {
        root.triggerRipple(root, rootX, rootY);
        openContextMenu();
    }

    function handleDrop(drop) {
        if (!ClipboardService.clipboardAvailable)
            return;

        if (drop.hasUrls && drop.urls.length > 0) {
            const fileUrls = drop.urls.map(url => url.toString()).filter(url => url.startsWith("file://"));
            if (fileUrls.length > 0) {
                DMSService.sendRequest("clipboard.store", {
                    "data": fileUrls.join("\r\n"),
                    "mimeType": "text/uri-list"
                }, response => {
                    if (response.error) {
                        ToastService.showError(I18n.tr("Failed to save dropped file"));
                        return;
                    }
                    root.showDropConfirmation();
                });
                return;
            }
        }

        if (drop.hasText && drop.text.length > 0) {
            DMSService.sendRequest("clipboard.store", {
                "data": drop.text,
                "mimeType": "text/plain;charset=utf-8"
            }, response => {
                if (response.error) {
                    ToastService.showError(I18n.tr("Failed to save dropped text"));
                    return;
                }
                root.showDropConfirmation();
            });
        }
    }

    function showDropConfirmation() {
        dropConfirmed = true;
        dropConfirmationTimer.restart();
    }

    Timer {
        id: dropConfirmationTimer
        interval: 1200
        onTriggered: root.dropConfirmed = false
    }

    function openContextMenu() {
        const anchor = root.contextMenuAnchor();
        contextMenu.openFromBar(anchor);
    }

    content: Component {
        Item {
            implicitWidth: icon.width
            implicitHeight: root.contentThickness

            property bool draggingOver: false

            DropArea {
                anchors.fill: parent
                anchors.margins: -root.horizontalPadding
                onEntered: draggingOver = true
                onExited: draggingOver = false
                onDropped: drop => {
                    draggingOver = false;
                    drop.accept(Qt.CopyAction);
                    root.handleDrop(drop);
                }
            }

            DIcon {
                id: icon
                anchors.centerIn: parent
                name: root.dropConfirmed ? "check" : "content_paste"
                size: Theme.barIconSize(root.barThickness, -4, root.barConfig?.maximizeWidgetIcons, root.barConfig?.iconScale)
                color: root.dropConfirmed || draggingOver ? Theme.primary : Theme.widgetIconColor
                scale: draggingOver ? 1.2 : 1.0

                Behavior on color {
                    ColorAnimation {
                        duration: 150
                    }
                }
                Behavior on scale {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutBack
                    }
                }
            }
        }
    }

    DContextMenu {
        id: contextMenu
        layerNamespace: "dms:clipboard-context-menu"
        menuItems: [
            {
                type: "item",
                icon: "delete_sweep",
                text: I18n.tr("Clear All"),
                action: () => root.clearAllRequested()
            },
            {
                type: "item",
                icon: "push_pin",
                text: I18n.tr("Show Saved Items"),
                action: () => root.showSavedItemsRequested()
            }
        ]
    }
}
