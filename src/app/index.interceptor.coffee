angular.module "imagewikiFrontend"
  .config (jwtInterceptorProvider, $httpProvider) ->
    jwtInterceptorProvider.tokenGetter = (store) ->
      store.get('jwt')

    $httpProvider.interceptors.push('jwtInterceptor')
