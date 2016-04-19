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
        else if response.status not in [200, 201]
          $rootScope.$broadcast 'showToastrMessage', { type: 'error', message: "Something went wrong please reach out to tech@imagewiki.org" }

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
        token = UserAuth.getToken()
        if token? then token else null
      ]
      $httpProvider.interceptors.push('jwtInterceptor', 'responseInterceptor')
  ]
