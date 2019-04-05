angular.module('scrapingUrl').controller('scrapingUrlsCtrl', [
  '$scope',
  'scrapingUrlService',
  function($scope, scrapingUrlService) {

    scrapingUrlService.getScrapingUrls().then(function(data) {
      $scope.urls = data.data
    })
  }
])
