angular.module "imagewikiFrontend"
  .directive 'bulkImageItem', ->
    restrict: 'E'
    templateUrl: 'app/bulk-upload/bulk-image-item.html'
    link: (scope, element, attr) ->
      console.log 'PREVIEW?', scope
      return

