angular.module('imvoices')
  .controller('LoginCtrl', ['$scope', 'Authentication',
                   function ($scope,   Authentication) {
  // Define Models
  $scope.user = {
    email: "",
    password: ""
  };

  $scope.loginError = null;
  $scope.loggingIn  = false;

  // Scope Methods
  $scope.login = function () {
    $scope.loggingIn = true; // Disable the login button

    Authentication.authenticate($scope.user.email, $scope.user.password).then(function () {
      alert('yay!');
    }, function (err) {
      $scope.loginError = "WHat";
      $scope.loggingIn = false;
    });
  }
}]);