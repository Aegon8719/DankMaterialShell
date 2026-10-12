pragma ComponentBehavior: Bound

import QtQuick
import qs.Common
import qs.Services
import "../../DCommon/Common/WheelInput.js" as WheelInput

MouseArea {
    id: root

    property bool scrollEnabled: true
    property string xBehavior: "column"
    property string yBehavior: "workspace"
    property string screenName: ""
    property var barConfig: null
    property real mouseAccumulatorX: 0
    property real mouseAccumulatorY: 0
    property bool actionInProgress: false

    signal workspaceSwitchRequested(int direction)

    acceptedButtons: Qt.NoButton

    Timer {
        id: cooldownTimer
        interval: 100
        onTriggered: root.actionInProgress = false
    }

    function handleScrollAction(behavior, direction) {
        switch (behavior) {
        case "workspace":
            workspaceSwitchRequested(direction);
            return true;
        case "column":
            if (!CompositorService.isNiri)
                return false;
            if (direction > 0)
                NiriService.moveColumnRight(screenName);
            else
                NiriService.moveColumnLeft(screenName);
            return true;
        default:
            return false;
        }
    }

    function fire(accumulated, behavior) {
        const reverse = SettingsData.widgetOption("workspaceSwitcher", SettingsData.barWidgetEntry(root.barConfig, "workspaceSwitcher"), "reverseScrolling") ? -1 : 1;
        const direction = accumulated * reverse < 0 ? 1 : -1;
        if (!handleScrollAction(behavior, direction))
            return;
        actionInProgress = true;
        cooldownTimer.restart();
    }

    function accumulateX(delta, behavior) {
        mouseAccumulatorX += delta;
        if (Math.abs(mouseAccumulatorX) < 120)
            return;
        fire(mouseAccumulatorX, behavior);
        mouseAccumulatorX = 0;
    }

    function accumulateY(delta, behavior) {
        mouseAccumulatorY += delta;
        if (Math.abs(mouseAccumulatorY) < 120)
            return;
        fire(mouseAccumulatorY, behavior);
        mouseAccumulatorY = 0;
    }

    function processWheel(wheel) {
        wheel.accepted = false;
        if (!scrollEnabled || actionInProgress)
            return;
        // Wayland finger scrolling carries a phase, including its zero-delta begin/end events.
        if (wheel.phase !== Qt.NoScrollPhase || WheelInput.isTouchpad(wheel))
            return;

        const deltaY = wheel.angleDelta.y;
        const deltaX = wheel.angleDelta.x;

        if (CompositorService.isNiri && xBehavior !== "none" && Math.abs(deltaX) > Math.abs(deltaY)) {
            wheel.accepted = true;
            accumulateX(deltaX, xBehavior);
            return;
        }
        if (yBehavior === "none")
            return;
        wheel.accepted = deltaY !== 0;
        accumulateY(deltaY, yBehavior);
    }

    onWheel: wheel => processWheel(wheel)
}
