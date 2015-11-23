angular.module "imagewikiFrontend"
  .factory 'UserAuth', [
    '$http',
    'API_URL',
    'UserStore',
    'jwtHelper'
    ($http, API_URL, UserStore, jwtHelper) ->
      userAuth = {}

      userLoggedIn = (res) ->
        user = jwtHelper.decodeToken(res.data)
        UserStore.set 'user', user
        user

      userAuth.register = (user) ->
        $http.post("#{API_URL}/users", user).then userLoggedIn

      userAuth.update = (id, user) ->
        $http.put("#{API_URL}/users/#{id}", user).then (res) ->
          res.data

      userAuth.login = (credentials) ->
        $http.post("#{API_URL}/auth", credentials).then userLoggedIn

      userAuth.logout = ->
        UserStore.remove 'user'

      userAuth.isAuthenticated = ->
        UserStore.get('user')?

      userAuth.getUser = ->
        UserStore.get('user') || null

      userAuth.fetchUser = (id) ->
        $http.get("#{API_URL}/users/#{id}").then (res) ->
          res

      userAuth.updateUserInfo = (user) ->
        storageUser = UserStore.get('user')
        angular.forEach user, (value, key) ->
          storageUser[key] = value
          return
        UserStore.set 'user', storageUser
        return

      userAuth
  ]