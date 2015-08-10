angular.module "imagewikiFrontend"
  .config [
    '$logProvider'
    ($logProvider) ->
        # Enable log
        $logProvider.debugEnabled true

        # Set options third-party lib

        # - TOASTR COMMENTED FOR FUTURE REFERENCES.
        # - tostr it's also passed as a parameter on .config method
        # toastr.options.timeOut = 3000
        # toastr.options.positionClass = 'toast-top-right'
        # toastr.options.preventDuplicates = true
        # toastr.options.progressBar = true
  ]
