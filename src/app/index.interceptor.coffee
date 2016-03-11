angular.module "imagewikiFrontend"
  .factory 'mockInterceptor', ->
    {
      request: (config) ->
        config.headers['Mock'] = 'true'
        config
    }
  .factory 'responseInterceptor', ['$q', '$rootScope', ($q, $rootScope) ->
    {
      responseError: (response) ->
        if response.status == 401
          $rootScope.$broadcast 'reAuthenticate', { message: response.data.error }
        return $q.reject response
    }]
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
      $httpProvider.interceptors.push('jwtInterceptor', 'responseInterceptor')
  ]
