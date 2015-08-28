angular.module "imagewikiFrontend"
  .config [
    '$logProvider'
    'toastrConfig'
    ($logProvider, toastrConfig) ->
      # Enable log
      $logProvider.debugEnabled true

      # Set options third-party lib

      # Toastr Configs
      angular.extend toastrConfig,
        timeOut           : 3000
        positionClass     : 'toast-top-right'
        progressBar       : true
        allowHtml         : true
  ]
