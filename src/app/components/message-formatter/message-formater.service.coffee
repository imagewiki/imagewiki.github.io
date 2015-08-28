angular.module "imagewikiFrontend"
  .factory 'MessageFormatter',
    ->
      formatter = {}

      formatter.error = (data) ->
        msg = ''
        angular.forEach data.error, (value, key) ->
          msg += "<strong>#{key}</strong>: #{value}"
          return
        msg

      formatter