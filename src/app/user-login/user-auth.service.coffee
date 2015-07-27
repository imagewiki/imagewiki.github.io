angular.module "imagewikiFrontend"
  .factory 'UserAuth', [
    '$http',
    'Session'
    ($http, Session) ->
      userAuth = {}

      userAuth.register = (user) ->
        $http.post('/register', user).then (res) ->
          Session.create res.data.id, res.data.user.id, res.data.user.role
          res.data.user

      userAuth.login = (credentials) ->
        $http.post('/login', credentials).then (res) ->
          Session.create res.data.id, res.data.user.id, res.data.user.role
          res.data.user

      userAuth.isAuthenticated = ->
        ! !Session.userId

      userAuth.isAuthorized = (authorizedRoles) ->
        if !angular.isArray(authorizedRoles)
          authorizedRoles = [ authorizedRoles ]
        userAuth.isAuthenticated() and authorizedRoles.indexOf(Session.userRole) != -1

      userAuth
  ]