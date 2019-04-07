angular.module('scrapingUrl').controller('scrapingUrlsCtrl', [
  '$scope',
  'scrapingUrlService',
  function($scope, scrapingUrlService) {

    scrapingUrlService.getScrapingUrls().then(function(data) {
      $scope.urls = data.data
    })

    $scope.delete = function(id) {
      scrapingUrlService.deleteScrapingUrl(id['$oid']).then(function() {
        scrapingUrlService.getScrapingUrls().then(function(data) {
          $scope.urls = data.data
        })
      })
    }

    $scope.calculatePbox = function(id) {
      scrapingUrlService.calculatePbox(id).then(function(data){
      })
    }

  }
])
