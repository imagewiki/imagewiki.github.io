angular.module('imagewikiFrontend')
  .constant 'API_URL', 'http://dev.api.image.wiki/v1'
  # .constant 'API_URL', 'http://localhost:3100/v1'
  .constant 'AUTH_EVENTS',
    loginSuccess: 'auth-login-success'
    loginFailed: 'auth-login-failed'
    logoutSuccess: 'auth-logout-success'
    sessionTimeout: 'auth-session-timeout'
    notAuthenticated: 'auth-not-authenticated'
    notAuthorized: 'auth-not-authorized'
  .constant 'USER_ROLES',
    all: '*'
    admin: 'admin'
    editor: 'editor'
    guest: 'guest'
