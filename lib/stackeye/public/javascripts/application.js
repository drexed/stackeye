$(document).ready(function() {
  var chartHandler = $('[data-toggle="chart"]');
  var charts = {};
  var colors = {
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
  };

  Chart.defaults.global.defaultColor = colors.primary[600];
  Chart.defaults.global.defaultFontColor = colors.gray[600];
  Chart.defaults.global.defaultFontFamily = 'Rubik';
  Chart.defaults.global.defaultFontSize = 13;
  Chart.defaults.global.elements.line.backgroundColor = colors.primary[100];
  Chart.defaults.global.elements.line.borderCapStyle = "rounded";
  Chart.defaults.global.elements.line.borderColor = colors.primary[700];
  Chart.defaults.global.elements.line.borderWidth = 1;
  Chart.defaults.global.elements.line.tension = 0;
  Chart.defaults.global.elements.point.backgroundColor= colors.primary[700];
  Chart.defaults.global.elements.point.borderColor= colors.transparent;
  Chart.defaults.global.elements.point.hitRadius = 10;
  Chart.defaults.global.elements.point.radius = 0;
  Chart.defaults.global.elements.rectangle.backgroundColor = colors.primary[700];
  Chart.defaults.global.legend.display = !1;
  Chart.defaults.global.legend.position = "bottom";
  Chart.defaults.global.legend.labels.usePointStyle = !0;
  Chart.defaults.global.legend.labels.padding = 16;
  Chart.defaults.global.maintainAspectRatio = !1;
  Chart.defaults.global.maxBarThickness = 10;
  Chart.defaults.global.responsive = !0;
  Chart.defaults.global.tooltips.backgroundColor = colors.black;
  Chart.defaults.global.tooltips.titleFontStyle = 500;
  Chart.defaults.global.tooltips.cornerRadius = 4;
  Chart.defaults.global.tooltips.xPadding = 10;
  Chart.defaults.global.tooltips.yPadding = 10;

  function generateTimeChartLabels(data) {
    var labels = [];

    for (var i = 1; i < data.length; i++) {
      // TODO: convert this to parse the timestamp moment.unix(value)
      labels.push(moment().subtract(i, 'minutes'));
    }

    return labels;
  }

  function generateAvgChartLabels(data) {
    var labels = [];

    for (var i = 1; i < data.length; i++) {
      labels.push(data);
    }

    return labels;
  }

  function createTimeLineChart(target, data) {
    return new Chart(document.getElementById(target), {
      type: "line",
      data: {
        labels: generateTimeChartLabels(data),
        datasets: [{
          steppedLine: true,
          data: data
        }]
      },
      options: {
        animation: {
          duration: 0
        },
        hover: {
          animationDuration: 0
        },
        responsiveAnimationDuration: 0,
        tooltips: {
          callbacks: {
            title: function(tooltipItem, data) {
              return tooltipItem[0].xLabel.format('MMMM Do YYYY, h:mm a');
            },
          }
        },
        scales: {
          xAxes: [{
            type: 'time',
            distribution: 'series',
            time: {
              minUnit: 'minute',
              displayFormats: {
                minute: 'h:mm a'
              }
            },
            gridLines: {
              display: !1,
              drawBorder: !1
            }
          }],
          yAxes: [{
            ticks : {
              beginAtZero: true
            },
            gridLines: {
              borderDash: [2],
              borderDashOffset: [2],
              color: colors.gray[300],
              drawBorder: !1,
              drawTicks: !1,
              lineWidth: 0,
              zeroLineWidth: 0,
              zeroLineColor: colors.gray[300],
              zeroLineBorderDash: [2],
              zeroLineBorderDashOffset: [2]
            }
          }]
        }
      }
    });
  };

  chartHandler.each(function (index) {
    var _this = $(this);
    var target = _this.data("target");
    var data = _this.data("data");

    if (!charts[target]) {
      charts[target] = createTimeLineChart(target, data);
    }
  });

  chartHandler.on("click", function () {
    var _this = $(this);
    var target = _this.data("target");
    var data = _this.data("data");

    createTimeLineChart(target, data);
  });

});
