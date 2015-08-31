angular.module('imagewikiFrontend')
   #.constant 'API_URL', 'http://localhost:3100/api'
  .constant 'API_URL', 'http://mocksvc.mulesoft.com/mocks/7ba5cb95-cbd0-4f31-a51c-5a057a3cab1d'
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
