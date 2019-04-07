angular.module('scrapingUrl').controller('scrapingFormUrlCtrl', [
  '$scope',
  '$window',
  'scrapingUrlService',
  function($scope, $window, scrapingUrlService) {
    $scope.formData = {}

    $scope.save = function() {
      scrapingUrlService.saveScrapingUrl($scope.formData).then(function(data) {
        $window.location.href = '/scraping_urls'
      }, function() {
        alert('Can not added item')
      })
    }
  }
])
