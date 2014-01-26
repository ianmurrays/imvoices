/**
 * Initialize the application module and configure the basics
 */
angular.module('imvoices', ['templates', 'restangular', 'ui.router'])
  .config(['RestangularProvider', '$stateProvider', '$urlRouterProvider', 
  function (RestangularProvider,   $stateProvider,   $urlRouterProvider) {
    // Configure Restangular
    RestangularProvider.setBaseUrl('/api/v1');

    // Configure States
    $urlRouterProvider.otherwise('/login');
    $stateProvider
      .state('login', {
        url: '/login',
        templateUrl: 'authentication/login.html',
        controller: 'LoginCtrl'
      });
  }]);