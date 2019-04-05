angular.module('scrapingUrl').controller('scrapingFormUrlCtrl', [
  '$scope',
  '$http',
  'scrapingUrlService',
  function($scope, $http, scrapingUrlService) {
    $scope.formData = {}
    $scope.save = function() {
      scrapingUrlService.saveScrapingUrl($scope.formData).then(function(data) {
        location.href = '/scraping_urls'
      })
    }
  }
])
