angular.module "imagewikiFrontend"
  .config (jwtInterceptorProvider, $httpProvider) ->

    # Adds JWT Interceptor to insert token on request header
    jwtInterceptorProvider.authHeader  = 'XAuthToken'
    jwtInterceptorProvider.authPrefix  = ''
    jwtInterceptorProvider.tokenGetter = ['UserAuth', (UserAuth) ->
      user = UserAuth.getUser()
      if user? then user.token else null
    ]
    $httpProvider.interceptors.push('jwtInterceptor')
