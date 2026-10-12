import QtQuick
import qs.Common

MultiPointTouchArea {
    id: root
    property string edge: "top"
    property point start: Qt.point(0, 0)
    property bool tracking: false
    signal activated(point position, bool swiped)
    anchors.fill: parent
    z: 100
    mouseEnabled: false
    minimumTouchPoints: 1
    maximumTouchPoints: 1
    onPressed: points => {
        start = Qt.point(points[0].x, points[0].y);
        tracking = true;
    }
    onCanceled: tracking = false
    onReleased: points => {
        if (!tracking)
            return;
        tracking = false;
        const dx = points[0].x - start.x;
        const dy = points[0].y - start.y;
        const inward = edge === "bottom" ? -dy : edge === "left" ? dx : edge === "right" ? -dx : dy;
        const cross = edge === "left" || edge === "right" ? dy : dx;
        const swipe = inward >= Theme.iconSize && inward > Math.abs(cross);
        if (swipe || Math.hypot(dx, dy) < Qt.styleHints.startDragDistance)
            activated(start, swipe);
    }
}
