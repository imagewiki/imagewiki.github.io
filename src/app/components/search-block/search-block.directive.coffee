angular.module "imagewikiFrontend"
  .directive 'searchBlock', [
    'searchBlockHelper'
    (searchBlockHelper) ->
        restrict: 'E'
        templateUrl: 'app/components/search-block/search-block.html'
        controller: 'SearchBlockController'
        controllerAs: 'searchBlock'
        link: (scope, element, attr) ->

          # Add event listeners that will handle the actions the user can execute on the search form
          # Check the searchBlockHelper (./search-block.module.coffe) to see the methods called below

          element.find('#new_search').submit (e) ->
            if searchBlockHelper.IsValidUrl($('#search_description').val()) or searchBlockHelper.isUploadImage($('#search_file'))
              return
            else
              alert 'Oops that’s not an image url'
              false

          element.find('#search_description').keyup ->
            searchBlockHelper.toggleThumbnailPreview this
            return

          return
  ]