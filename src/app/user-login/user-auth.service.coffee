angular.module "imagewikiFrontend"
  .factory 'UserAuth', [
    '$http',
    'API_URL',
    'UserStore'
    ($http, API_URL, UserStore) ->
      userAuth = {}

      userAuth.register = (user) ->
        $http.post("#{API_URL}/register", user).then (res) ->
          UserStore.set 'user', res.data
          res.data.user

      userAuth.login = (credentials) ->
        $http.post("#{API_URL}/auth", credentials).then (res) ->
          UserStore.set 'user', res.data
          res.data

      userAuth.isAuthenticated = ->
        false

      userAuth
  ]