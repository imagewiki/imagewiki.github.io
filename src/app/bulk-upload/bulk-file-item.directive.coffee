angular.module "imagewikiFrontend"
  .directive 'bulkFileItem', ->
    restrict: 'E'
    templateUrl: 'app/bulk-upload/bulk-file-item.html'
    link: (scope, element, attr) ->
      return

