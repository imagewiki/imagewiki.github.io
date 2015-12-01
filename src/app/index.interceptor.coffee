angular.module "imagewikiFrontend"
  .factory 'mockInterceptor', ->
    {
      request: (config) ->
        config.headers['Mock'] = 'true'
        config
    }
  .config [
    'jwtInterceptorProvider'
    '$httpProvider'
    (jwtInterceptorProvider, $httpProvider) ->

      # Adds JWT Interceptor to insert token on request header
      jwtInterceptorProvider.authHeader  = 'XAuthToken'
      jwtInterceptorProvider.authPrefix  = ''
      jwtInterceptorProvider.tokenGetter = ['UserAuth', (UserAuth) ->
        user = UserAuth.getUser()
        if user? then user.token else null
      ]
      $httpProvider.interceptors.push('jwtInterceptor', 'mockInterceptor')
  ]
