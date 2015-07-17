angular.module "imagewikiFrontend"
  .directive 'searchBlock', [
    'searchBlockHelper'
    (searchBlockHelper) ->
        restrict: 'E'
        templateUrl: 'app/components/search-block/search-block.html'
        link: (scope, element, attr) ->

          # Add event listeners that will handle the actions the user can execute on the search form
          # Check the searchBlockHelper (./search-block.module.coffe) to see the methods called below

          element.find('#new_search').submit (e) ->
            if searchBlockHelper.IsValidUrl($('#search_description').val()) or searchBlockHelper.isUploadImage($('#search_file'))
              return
            else
              alert 'Oops that’s not an image url'
              false

          element.find('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
            activated_tab = $(e.target).attr('href')
            searchBlockHelper.setOption activated_tab
            return

          element.find('#search_description').keyup ->
            searchBlockHelper.toggleThumbnailPreview this
            return

          element.find('.browse-your-files').click ->
            $('#search_file').click()
            return

          element.find('#search_file').change (e) ->
            if !searchBlockHelper.isUploadImage($(this))
              alert 'Oops the file you choose isn\'t an image'
              $(this).val ''
              return false
            searchBlockHelper.uploadAndShowFile $(this), e
            return
          return
  ]