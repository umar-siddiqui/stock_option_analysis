angular.module('scrapingUrl', [])

angular.module('scrapingUrl').factory('PromiseFactory', [
  '$http',
  '$q',
  function ($http, $q) {

    var factory = {}

    factory.generateHttpPromise = function (requestDetails) {
      var deferred = $q.defer();

      $http(requestDetails).then(function (data, status, fnc, httpObj) {
        deferred.resolve(data, status, fnc, httpObj);
      })
      // .error(function (data, status, fnc, httpObj) {
      //   var errorResponse = {
      //     data: data,
      //     status: status
      //   };
      //   deferred.reject(errorResponse);
      // })

      return deferred.promise;
    }

    return factory;
  }

])


angular.module('scrapingUrl').service('scrapingUrlService',[
  'PromiseFactory',
  function(PromiseFactory) {

    this.getScrapingUrl = function (id) {
      var requestDetails = {
        url: '/scraping_urls/' + id + '.json',
        method: 'GET'
      }
      return PromiseFactory.generateHttpPromise(requestDetails);
    }

    this.getScrapingUrls = function (id) {
      var requestDetails = {
        url: '/scraping_urls.json',
        method: 'GET'
      }
      return PromiseFactory.generateHttpPromise(requestDetails);
    }

    this.saveScrapingUrl = function (scrapingUrl) {
      var requestDetails = {
        url: '/scraping_urls.json',
        method: 'POST',
        data: { scrapping_url: scrapingUrl }
      }
      return PromiseFactory.generateHttpPromise(requestDetails);
    }

    this.deleteScrapingUrl = function (id) {
      var requestDetails = {
        url: '/scraping_urls/' + id + '.json',
        method: 'DELETE',
      }
      return PromiseFactory.generateHttpPromise(requestDetails);
    }

    this.calculatePbox = function (id) {
      var requestDetails = {
        url: '/scraping_urls/' + id + '/calculate_pbox.json',
        method: 'GET',
      }
      return PromiseFactory.generateHttpPromise(requestDetails);
    }
  }
])
