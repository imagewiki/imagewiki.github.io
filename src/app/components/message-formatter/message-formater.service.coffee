angular.module "imagewikiFrontend"
  .factory 'MessageFormatter',
    ->
      formatter = {}

      formatter.error = (data) ->
        error = if angular.isString(data.error) then angular.fromJson(data.error) else data.error
        msg = ''
        angular.forEach error, (value, key) ->
          msg += "<strong>#{key}</strong>: #{value}"
          return
        msg

      formatter