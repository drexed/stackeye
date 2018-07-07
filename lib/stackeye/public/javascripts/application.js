/*
  Use this file to add custom scripts.
  Please do not override any of the other files
*/

$(document).ready(function() {
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
  Chart.defaults.global.elements.point.backgroundColor = colors.primary[700];
  Chart.defaults.global.elements.point.borderColor = colors.transparent;
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

  function generateTimeChartLabels(options) {
    var labels = [];

    $.each(options.timestamps, function(index, value) {
      labels.push(new Date(value * 1000));
    });

    return labels;
  }

  function generateMeanChartLabels(options) {
    var labels = [];

    for (var i = 1; i < options.metrics.length; i++) {
      labels.push(options.mean);
    }

    return labels;
  }

  function createTimeChart(options) {
    return new Chart(document.getElementById(options.target), {
      type: "line",
      data: {
        labels: options.labels,
        datasets: [{
          label: "Average",
          data: options.mean,
          fill: false,
          backgroundColor: colors.black,
          borderColor: colors.black,
          borderWidth: 1
        },
        {
          steppedLine: true,
          data: options.metrics
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
  }

  function createDoughnutChart(options) {
    return new Chart(document.getElementById(options.target), {
        type: 'doughnut',
        data: {
          labels: options.labels,
          datasets: [{
            data: options.metrics,
            borderWidth: 0,
            backgroundColor: [
              colors.primary[700],
              colors.black
            ]
          }]
        },
        options: {
          cutoutPercentage: 75,
          tooltips: {
            callbacks: {
              label: function(tooltipItems, data) {
                // TODO: mage this an option

                return data.labels[tooltipItems.index] +
                       ': ' +
                       data.datasets[tooltipItems.datasetIndex].data[tooltipItems.index] +
                       'GB';
              }
            }
          }
        }
    });
  }

  function createChartByType(options) {
    var chart;

    switch(options.type) {
      case 'doughnut':
        createDoughnutChart(options);
        break;
      case 'time':
        options.labels = generateTimeChartLabels(options);
        options.mean = generateMeanChartLabels(options);
        chart = createTimeChart(options);
    };

    return chart;
  }

  function expandChartCards(options) {
    $(options.contract).addClass('d-none');
    $(options.expand).removeClass('d-none');
  }

  var charts = {};
  var chartHandler = $('[data-toggle="chart"]');
  chartHandler.each(function (index) {
    var self = $(this);
    var options = {
      target: self.data("target")
    };

    if (!charts[options.target]) {
      $.each([
        "type", "labels", "metrics", "mean", "timestamps"
      ], function(i, value) {
        options[value] = self.data(value);
      });

      charts[options.target] = createChartByType(options);
    }
  });

  chartHandler.on("click", function () {
    var self = $(this);
    var options = {};

    $.each([
      "target", "labels", "type", "metrics", "mean", "timestamps"
    ], function(i, value) {
      options[value] = self.data(value);
    });

    createChartByType(options);
  });

  var expandHandler = $('[data-expand]');
  expandHandler.on("click", function () {
    var self = $(this);
    var options = {
      contract: self.data("contract"),
      expand: self.data("expand")
    };

    expandChartCards(options);
  });

});
