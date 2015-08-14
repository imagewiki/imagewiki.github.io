angular.module "imagewikiFrontend"
  .factory 'UserAuth', [
    '$http',
    'API_URL',
    'UserStore',
    'jwtHelper'
    ($http, API_URL, UserStore, jwtHelper) ->
      userAuth = {}

      userLoggedIn = (res) ->
        UserStore.set 'user', res.data
        jwtHelper.decodeToken(res.data)

      userAuth.register = (user) ->
        $http.post("#{API_URL}/users", user).then userLoggedIn

      userAuth.login = (credentials) ->
        $http.post("#{API_URL}/auth", credentials).then userLoggedIn

      userAuth.logout = ->
        UserStore.remove 'user'

      userAuth.isAuthenticated = ->
        UserStore.get('user')?

      userAuth.getUser = ->
        user = UserStore.get 'user'
        if user? then jwtHelper.decodeToken user else null

      userAuth
  ]