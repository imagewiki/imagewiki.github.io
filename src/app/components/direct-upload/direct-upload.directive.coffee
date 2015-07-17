angular.module "imagewikiFrontend"
  .directive 'directUpload', ->
    directive =
      restrict: 'E'
      templateUrl: 'app/components/direct-upload/direct-upload.html'
      link: (scope, element, attr) ->
        element.find('a.button').click ->
          element.find('#direct-input-file').click()
        element.find('#direct-input-file').change ->
          element.find('form').attr('action', '/create-image').submit()
        return
