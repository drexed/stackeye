Chart.elements.Rectangle.prototype.draw = function() {
    var t,
        e,
        i,
        r,
        h,
        o,
        d,
        a = this._chart.ctx,
        n = this._view,
        l = n.borderWidth;
    if (n.horizontal ? (t = n.base, e = n.x, i = n.y - n.height / 2, r = n.y + n.height / 2, h = t < e ? 1 : -1, o = 1, d = n.borderSkipped || "left") : (t = n.x - n.width / 2, e = n.x + n.width / 2, h = 1, o = (i = n.y) < (r = n.base) ? 1 : -1, d = n.borderSkipped || "bottom"), l) {
        var g = Math.min(Math.abs(t - e), Math.abs(i - r)),
            b = (l = g < l ? g : l) / 2,
            v = t + ("left" !== d ? b * h : 0),
            w = e + ("right" !== d ? -b * h : 0),
            u = i + ("top" !== d ? b * o : 0),
            C = r + ("bottom" !== d ? -b * o : 0);
        v !== w && (i = u, r = C), u !== C && (t = v, e = w)
    }
    a.beginPath(), a.fillStyle = n.backgroundColor, a.strokeStyle = n.borderColor, a.lineWidth = l;
    var c = [[t, r], [t, i], [e, i], [e, r]],
        f = ["bottom", "left", "top", "right"].indexOf(d, 0);
    function T(t) {
        return c[(f + t) % 4]
    }
    -1 === f && (f = 0);
    var s = T(0);
    a.moveTo(s[0], s[1]);
    for (var p = 1; p < 4; p++) {
        var m;
        s = T(p), nextCornerId = p + 1, 4 == nextCornerId && (nextCornerId = 0), nextCorner = T(nextCornerId), width = c[2][0] - c[1][0], height = c[0][1] - c[1][1], x = c[1][0], y = c[1][1], (m = 6) > height / 2 && (m = height / 2), m > width / 2 && (m = width / 2), a.moveTo(x + m, y), a.lineTo(x + width - m, y), a.quadraticCurveTo(x + width, y, x + width, y + m), a.lineTo(x + width, y + height - m), a.quadraticCurveTo(x + width, y + height, x + width - m, y + height), a.lineTo(x + m, y + height), a.quadraticCurveTo(x, y + height, x, y + height - m), a.lineTo(x, y + m), a.quadraticCurveTo(x, y, x + m, y)
    }
    a.fill(), l && a.stroke()
};
