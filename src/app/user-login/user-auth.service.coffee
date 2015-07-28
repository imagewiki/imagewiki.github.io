angular.module "imagewikiFrontend"
  .factory 'UserAuth', [
    '$http',
    'API_URL',
    'UserStore',
    'jwtHelper'
    ($http, API_URL, UserStore, jwtHelper) ->
      userAuth = {}

      userAuth.register = (user) ->
        $http.post("#{API_URL}/register", user).then (res) ->
          UserStore.set 'user', res.data
          res.data.user

      userAuth.login = (credentials) ->
        $http.post("#{API_URL}/auth", credentials).then (res) ->
          UserStore.set 'user', res.data
          jwtHelper.decodeToken(res.data)

      userAuth.logout = ->
        UserStore.remove 'user'

      userAuth.isAuthenticated = ->
        UserStore.get('user')?

      userAuth.getUser = ->
        user = UserStore.get 'user'
        if user? then jwtHelper.decodeToken user else null

      userAuth
  ]