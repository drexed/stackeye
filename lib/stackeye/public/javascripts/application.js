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
  Chart.defaults.global.elements.line.backgroundColor = colors.transparent;
  Chart.defaults.global.elements.line.borderCapStyle = "rounded";
  Chart.defaults.global.elements.line.borderColor = colors.primary[700];
  Chart.defaults.global.elements.line.borderWidth = 3;
  Chart.defaults.global.elements.line.tension = .4;
  Chart.defaults.global.elements.point.radius = 0;
  Chart.defaults.global.elements.point.backgroundColor= colors.primary[700];
  Chart.defaults.global.legend.display = !1;
  Chart.defaults.global.legend.position = "bottom";
  Chart.defaults.global.legend.labels.usePointStyle = !0;
  Chart.defaults.global.legend.labels.padding = 16;
  Chart.defaults.global.maintainAspectRatio = !1;
  Chart.defaults.global.responsive = !0;

  function updateChart(chart, update) {


    console.log(chart);
    console.log(update.data);

    // if (update.data) {
      chart.data = update.data;
    // }
    // chart.data.datasets.forEach((dataset) => {
    //     dataset.data.push([1,2,3,4,5,6,7,8,9,10,11,12]);
    // });

    chart.update();
  }

  function createLineChart(target, update) {
    var options = $.extend({ type: 'line' }, update);
    var ctx = document.getElementById(target).getContext('2d');

    return new Chart(ctx, options);
  };

  chartHandler.each(function (index) {
    var _this = $(this);
    var target = _this.data("target");
    var update = _this.data("update");

    if (!charts[target]) {
      charts[target] = createLineChart(target, update);
    }
  });

  chartHandler.on("click", function () {
    var _this = $(this);
    var target = _this.data("target");
    var update = _this.data("update");

    updateChart(charts[target], update);
  });

});
