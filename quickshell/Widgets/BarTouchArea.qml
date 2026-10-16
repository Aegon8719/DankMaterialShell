import QtQuick
import qs.Common

MultiPointTouchArea {
    id: root
    property string edge: "top"
    property bool swipeEnabled: true
    property point start: Qt.point(0, 0)
    property bool tracking: false
    property bool dragged: false
    signal activated(point position, bool swiped)
    anchors.fill: parent
    z: 100
    mouseEnabled: false
    minimumTouchPoints: 1
    maximumTouchPoints: 1
    onPressed: points => {
        start = Qt.point(points[0].x, points[0].y);
        tracking = true;
        dragged = false;
    }
    onUpdated: points => {
        if (tracking && Math.hypot(points[0].x - start.x, points[0].y - start.y) >= Qt.styleHints.startDragDistance)
            dragged = true;
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
        const swipe = swipeEnabled && inward >= Theme.iconSize && inward > Math.abs(cross);
        if (swipe || (!dragged && Math.hypot(dx, dy) < Qt.styleHints.startDragDistance))
            activated(start, swipe);
    }
}
