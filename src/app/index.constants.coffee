angular.module('imagewikiFrontend')
  .constant 'API_URL', 'http://dev.api.image.wiki/v1'
  # .constant 'API_URL', 'http://mocksvc.mulesoft.com/mocks/679fced6-1a08-4668-b1b8-669237731cd2/mocks/e10a2c6d-880d-43f6-8db4-11ffb878b60a'
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
