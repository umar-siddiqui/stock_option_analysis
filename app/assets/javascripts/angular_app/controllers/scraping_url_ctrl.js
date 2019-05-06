angular.module('scrapingUrl').controller('scrapingUrlCtrl', [
  '$scope',
  '$filter',
  '$window',
  'scrapingUrlService',
  function($scope, $filter, $window, scrapingUrlService) {
    var id = window.location.href.split('/')[window.location.href.split('/').length - 1]

    var date_timeline = []
    var pbox_values = []

    scrapingUrlService.getScrapingUrl(id).then(function(data) {
      $scope.url = data.data.scrapping_url_show
      angular.forEach($scope.url.pboxes, function(item) {
        var date = $filter('date')(item.created_at, "dd/MM/yyyy")
        date_timeline.push(date),
        pbox_values.push(item.pbox_value)
      })

      var myChart = echarts.init(document.getElementById('main'));

      // specify chart configuration item and data
      var option = {
          title: {
              text: 'ECharts entry example'
          },
          tooltip: {},
          legend: {
              data:['Sales']
          },
          xAxis: {
              data: date_timeline
          },
          yAxis: {},
          series: [{
              name: 'Sales',
              type: 'line',
              data: pbox_values
          }]
      };

      // use configuration item and data specified to show chart
      myChart.setOption(option);
    })


    $scope.calculatePbox = function(id) {
      scrapingUrlService.calculatePbox(id).then(function(data){
        $window.location.reload();
      })
    }
  }
])
