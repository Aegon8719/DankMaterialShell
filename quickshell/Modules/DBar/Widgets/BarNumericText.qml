pragma ComponentBehavior: Bound

import QtQuick
import qs.Common
import qs.DCommon.Widgets

NumericText {
    id: root
    property string widthTemplate: ""

    isMonospace: false
    font.family: Theme.fontFamily
    font.weight: Theme.fontWeight
    font.features: ({"tnum": 1})
    horizontalAlignment: Text.AlignHCenter
    width: Math.ceil(widthTemplate !== "" ? templateMetrics.advanceWidth : reservedWidth)

    StyledTextMetrics {
        id: templateMetrics
        font: root.font
        text: root.widthTemplate
    }
}
