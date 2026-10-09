.pragma library

// Layer-shell reserves integer logical pixels; paint in physical pixels and split
// the remaining clearance equally, with at most one physical pixel of asymmetry.
function edge(nativeGapPx, thickness, scale, referenceGapPx) {
    scale = scale > 0 ? scale : 1;
    const thicknessPx = Math.round(thickness * scale);
    const native = Math.max(0, nativeGapPx);
    // Keep the reservation independent of fitting/resize remainders, or the
    // panel and Conscia can resize each other indefinitely.
    const reference = Math.max(0, referenceGapPx ?? native);
    const exclusive = Math.max(0, Math.round((thicknessPx + reference) / scale));
    const outerPx = Math.max(0, Math.round((Math.round(exclusive * scale) + native - thicknessPx) / 2));
    return { gap: outerPx / scale, exclusive: exclusive };
}

function lengthPadding(length, mode, percent, leading, trailing, scale) {
    const padding = mode === "percent" ? length * (1 - Math.min(100, Math.max(10, percent)) / 100) / 2
                  : mode === "fit" ? Math.min(leading, trailing) : 0;
    return Math.max(0, Math.round(padding * scale) / scale);
}
