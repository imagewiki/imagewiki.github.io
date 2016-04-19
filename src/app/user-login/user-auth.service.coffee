angular.module "imagewikiFrontend"
  .factory 'UserAuth', [
    '$http'
    'API_URL'
    'UserStore'
    ($http, API_URL, UserStore) ->
      userAuth = {}

      userLoggedIn = (res) ->
        return res.data if res.data.error
        UserStore.set 'token', res.data
        { success: true }

      userAuth.info = ->
        $http.get("#{API_URL}/user").then (res) ->
          UserStore.set 'user', res.data
          res.data

      userAuth.register = (user) ->
        $http.post("#{API_URL}/users", user).then userLoggedIn

      userAuth.update = (id, user) ->
        $http.put("#{API_URL}/users/#{id}", user).then (res) ->
          res.data

      userAuth.login = (credentials) ->
        $http.post("#{API_URL}/auth", credentials).then userLoggedIn

      userAuth.logout = ->
        UserStore.remove 'user'
        UserStore.remove 'token'
        return

      userAuth.isAuthenticated = ->
        UserStore.get('user')?

      userAuth.getUser = ->
        UserStore.get('user') || null

      userAuth.getToken = ->
        UserStore.get('token') || null

      userAuth.fetchUser = (id) ->
        $http.get("#{API_URL}/users/#{id}").then (res) ->
          res

      userAuth.userDefaults = (id) ->
        $http.get("#{API_URL}/users/#{id}/default_values").then (res) ->
          res

      userAuth.updateUserInfo = (user) ->
        storageUser = UserStore.get('user')
        angular.forEach user, (value, key) ->
          storageUser[key] = value
          return
        UserStore.set 'user', storageUser
        return

      userAuth.recoverPassword = (user) ->
        $http.post("#{API_URL}/users/password-recovery", user).then (res) ->
          res.data

      userAuth.resetPassword = (reset_password) ->
        $http.post("#{API_URL}/users/reset-password", reset_password).then userLoggedIn

      userAuth
  ]