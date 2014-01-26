angular.module('imvoices')
  .factory('Authentication', ['Restangular', '$window', '$q', 
                     function (Restangular,   $window,   $q) {
  var authentication = {
    get authenticationToken () {
      return $window.sessionStorage.imvoicesJWT
    },

    set authenticationToken (token) {
      $window.sessionStorage.imvoicesJWT = token;
    },

    loggedIn: function () {
      return this.authenticationToken !== null;
    },

    /**
     * Authenticates a user and returns a promise
     */
    authenticate: function (email, password) {
      var deferred = $q.defer()
        , self     = this;

      Restangular.all('users').customPOST({
        user: {
          email: email,
          password: password
        }
      }, 'authenticate').then(function (response) {
        self.authenticationToken = response.token;
        Restangular.configuration.defaultHeaders = {
          'Authorization': 'Bearer ' + self.authenticationToken
        };

        // Request the default profile
        Restangular.one('users', 'me').get().then(function (user) {
          debugger;
        }, function (err) {
          debugger
        });

        deferred.resolve();
      }, function (err) {
        deferred.reject(err);
      });

      return deferred.promise;
    },

    /**
     * Removes the session's token
     */
    logout: function () {
      this.authenticationToken = null;
    }
  };

  return authentication;
}]);
