"use strict";
var Dropdowns = function() {
        var t = $(".dropup, .dropright, .dropdown, .dropleft"),
            e = $(".dropdown-menu"),
            r = $(".dropdown-menu .dropdown-menu");
        $(".dropdown-menu .dropdown-toggle").on("click", function() {
            var a;
            return (a = $(this)).closest(t).siblings(t).find(e).removeClass("show"), a.next(r).toggleClass("show"), !1
        }), t.on("hide.bs.dropdown", function() {
            var a,
                t;
            a = $(this), (t = a.find(r)).length && t.removeClass("show")
        })
    }(),
    ThemeCharts = function() {
        var a = $('[data-toggle="chart"]'),
            t = {
                base: "Cerebri Sans"
            },
            e = {
                gray: {
                    100: "#95AAC9",
                    300: "#E3EBF6",
                    600: "#95AAC9",
                    700: "#6E84A3",
                    900: "#283E59"
                },
                primary: {
                    100: "#D2DDEC",
                    300: "#A6C5F7",
                    700: "#2C7BE5"
                },
                black: "#12263F",
                white: "#FFFFFF",
                transparent: "transparent"
            },
            r = {
                defaults: {
                    global: {
                        responsive: !0,
                        maintainAspectRatio: !1,
                        defaultColor: e.primary[600],
                        defaultFontColor: e.gray[600],
                        defaultFontFamily: t.base,
                        defaultFontSize: 13,
                        layout: {
                            padding: 0
                        },
                        legend: {
                            display: !1,
                            position: "bottom",
                            labels: {
                                usePointStyle: !0,
                                padding: 16
                            }
                        },
                        elements: {
                            point: {
                                radius: 0,
                                backgroundColor: e.primary[700]
                            },
                            line: {
                                tension: .4,
                                borderWidth: 3,
                                borderColor: e.primary[700],
                                backgroundColor: e.transparent,
                                borderCapStyle: "rounded"
                            },
                            rectangle: {
                                backgroundColor: e.primary[700]
                            },
                            arc: {
                                borderWidth: 4,
                                backgroundColor: e.primary[700]
                            }
                        },
                        tooltips: {
                            enabled: !1,
                            mode: "index",
                            intersect: !1,
                            custom: function(o) {
                                var a = $("#chart-tooltip");
                                if (a.length || (a = $('<div id="chart-tooltip" class="popover bs-popover-top" role="tooltip"></div>'), $("body").append(a)), 0 !== o.opacity) {
                                    if (o.body) {
                                        var t = o.title || [],
                                            n = o.body.map(function(a) {
                                                return a.lines
                                            }),
                                            s = "";
                                        s += '<div class="arrow"></div>', t.forEach(function(a) {
                                            s += '<h3 class="popover-header text-center">' + a + "</h3>"
                                        }), n.forEach(function(a, t) {
                                            var e = '<span class="popover-body-indicator" style="' + ("background-color: " + o.labelColors[t].backgroundColor) + '"></span>',
                                                r = 1 < n.length ? "justify-content-left" : "justify-content-center";
                                            s += '<div class="popover-body d-flex align-items-center ' + r + '">' + e + a + "</div>"
                                        }), a.html(s)
                                    }
                                    var e = $(this._chart.canvas),
                                        r = (e.outerWidth(), e.outerHeight(), e.offset().top),
                                        l = e.offset().left,
                                        i = a.outerWidth(),
                                        d = a.outerHeight(),
                                        c = r + o.caretY - d - 16,
                                        p = l + o.caretX - i / 2;
                                    a.css({
                                        top: c + "px",
                                        left: p + "px",
                                        display: "block"
                                    })
                                } else
                                    a.css("display", "none")
                            },
                            callbacks: {
                                label: function(a, t) {
                                    var e = t.datasets[a.datasetIndex].label || "",
                                        r = a.yLabel,
                                        o = "";
                                    return 1 < t.datasets.length && (o += '<span class="popover-body-label mr-auto">' + e + "</span>"), o += '<span class="popover-body-value">$' + r + "k</span>"
                                }
                            }
                        }
                    },
                    doughnut: {
                        cutoutPercentage: 83,
                        tooltips: {
                            callbacks: {
                                title: function(a, t) {
                                    return t.labels[a[0].index]
                                },
                                label: function(a, t) {
                                    var e = "";
                                    return e += '<span class="popover-body-value">' + t.datasets[0].data[a.index] + "%</span>"
                                }
                            }
                        },
                        legendCallback: function(a) {
                            var r = a.data,
                                o = "";
                            return r.labels.forEach(function(a, t) {
                                var e = r.datasets[0].backgroundColor[t];
                                o += '<span class="chart-legend-item">', o += '<i class="chart-legend-indicator" style="background-color: ' + e + '"></i>', o += a, o += "</span>"
                            }), o
                        }
                    }
                }
            };
        function o(a, t) {
            for (var e in t)
                "object" != typeof t[e] ? a[e] = t[e] : o(a[e], t[e])
        }
        function n(a) {
            var t = a.data("add"),
                e = $(a.data("target")).data("chart");
            a.is(":checked") ? function a(t, e) {
                for (var r in e)
                    Array.isArray(e[r]) ? e[r].forEach(function(a) {
                        t[r].push(a)
                    }) : a(t[r], e[r])
            }(e, t) : function a(t, e) {
                for (var r in e)
                    Array.isArray(e[r]) ? e[r].forEach(function(a) {
                        t[r].pop()
                    }) : a(t[r], e[r])
            }(e, t), e.update()
        }
        function s(a) {
            var t = a.data("update"),
                e = $(a.data("target")).data("chart");
            o(e, t), function(a, t) {
                if (void 0 !== a.data("prefix") || void 0 !== a.data("prefix")) {
                    var n = a.data("prefix") ? a.data("prefix") : "",
                        s = a.data("suffix") ? a.data("suffix") : "";
                    t.options.scales.yAxes[0].ticks.callback = function(a) {
                        if (!(a % 10))
                            return n + a + s
                    }, t.options.tooltips.callbacks.label = function(a, t) {
                        var e = t.datasets[a.datasetIndex].label || "",
                            r = a.yLabel,
                            o = "";
                        return 1 < t.datasets.length && (o += '<span class="popover-body-label mr-auto">' + e + "</span>"), o += '<span class="popover-body-value">' + n + r + s + "</span>"
                    }
                }
            }(a, e), e.update()
        }
        return Chart.scaleService.updateScaleDefaults("linear", {
            gridLines: {
                borderDash: [2],
                borderDashOffset: [2],
                color: e.gray[300],
                drawBorder: !1,
                drawTicks: !1,
                lineWidth: 0,
                zeroLineWidth: 0,
                zeroLineColor: e.gray[300],
                zeroLineBorderDash: [2],
                zeroLineBorderDashOffset: [2]
            },
            ticks: {
                beginAtZero: !0,
                padding: 10,
                callback: function(a) {
                    if (!(a % 10))
                        return "$" + a + "k"
                }
            }
        }), Chart.scaleService.updateScaleDefaults("category", {
            gridLines: {
                drawBorder: !1,
                drawOnChartArea: !1,
                drawTicks: !1
            },
            ticks: {
                padding: 20
            },
            maxBarThickness: 10
        }), o(Chart, r), a.on({
            change: function() {
                var a = $(this);
                a.is("[data-add]") && n(a)
            },
            click: function() {
                var a = $(this);
                a.is("[data-update]") && s(a)
            }
        }), {
            fonts: t,
            colors: e,
            options: r
        }
    }(),
    Header = function() {
        var a,
            t,
            e = $("#headerChart");
        e.length && (a = e, t = new Chart(a, {
            type: "line",
            options: {
                scales: {
                    yAxes: [{
                        gridLines: {
                            color: ThemeCharts.colors.gray[900],
                            zeroLineColor: ThemeCharts.colors.gray[900]
                        }
                    }]
                }
            },
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                    label: "Performance",
                    data: [0, 10, 5, 15, 10, 20, 15, 25, 20, 30, 25, 40]
                }]
            }
        }), a.data("chart", t))
    }(),
    Performance = function() {
        var a,
            t,
            e = $("#performanceChart");
        e.length && (a = e, t = new Chart(a, {
            type: "line",
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                    label: "Performance",
                    data: [0, 10, 5, 15, 10, 20, 15, 25, 20, 30, 25, 40]
                }]
            }
        }), a.data("chart", t))
    }(),
    PerformanceAlias = function() {
        var a,
            t,
            e = $("#performanceChartAlias");
        e.length && (a = e, t = new Chart(a, {
            type: "line",
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                    label: "Performance",
                    data: [0, 10, 5, 15, 10, 20, 15, 25, 20, 30, 25, 40]
                }]
            }
        }), a.data("chart", t))
    }(),
    Orders = function() {
        var a,
            t,
            e = $("#ordersChart");
        e.length && (a = e, t = new Chart(a, {
            type: "bar",
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                    label: "Sales",
                    data: [25, 20, 30, 22, 17, 10, 18, 26, 28, 26, 20, 32]
                }]
            }
        }), a.data("chart", t))
    }(),
    OrdersAlias = function() {
        var a,
            t,
            e = $("#ordersChartAlias");
        e.length && (a = e, t = new Chart(a, {
            type: "bar",
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                    label: "Sales",
                    data: [25, 20, 30, 22, 17, 10, 18, 26, 28, 26, 20, 32]
                }]
            }
        }), a.data("chart", t))
    }(),
    Devices = function() {
        var a,
            t,
            e,
            r,
            o,
            n = $("#devicesChart");
        n.length && (r = n, o = new Chart(r, {
            type: "doughnut",
            data: {
                labels: ["Desktop", "Tablet", "Mobile"],
                datasets: [{
                    data: [60, 25, 15],
                    backgroundColor: [ThemeCharts.colors.primary[700], ThemeCharts.colors.primary[300], ThemeCharts.colors.primary[100]],
                    hoverBorderColor: ThemeCharts.colors.white
                }]
            }
        }), r.data("chart", o), t = (a = n).data("chart").generateLegend(), e = a.data("target"), $(e).html(t))
    }(),
    WeeklyHours = function() {
        var a,
            t,
            e = $("#weeklyHoursChart");
        e.length && (a = e, t = new Chart(a, {
            type: "bar",
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            callback: function(a) {
                                if (!(a % 10))
                                    return a + "hrs"
                            }
                        }
                    }]
                },
                tooltips: {
                    callbacks: {
                        label: function(a, t) {
                            var e = t.datasets[a.datasetIndex].label || "",
                                r = a.yLabel,
                                o = "";
                            return 1 < t.datasets.length && (o += '<span class="popover-body-label mr-auto">' + e + "</span>"), o += '<span class="popover-body-value">' + r + "hrs</span>"
                        }
                    }
                }
            },
            data: {
                labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                datasets: [{
                    data: [21, 12, 28, 15, 5, 12, 17, 2]
                }]
            }
        }), a.data("chart", t))
    }(),
    Navbar = function() {
        var t = $(".navbar-nav, .navbar-nav .nav"),
            e = $(".navbar-nav .collapse");
        e.on({
            "show.bs.collapse": function() {
                var a;
                (a = $(this)).closest(t).find(e).not(a).collapse("hide")
            }
        })
    }(),
    Tooltip = function() {
        var a = $('[data-toggle="tooltip"]');
        a.length && a.tooltip()
    }(),
    Popover = function() {
        var a = $('[data-toggle="popover"]');
        a.length && a.popover()
    }();
