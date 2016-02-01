angular.module "imagewikiFrontend"
  .factory 'ImageSelects',
    ->
      imageSelects = {}

      selects = {}
      selects.license_type_id = [
        { id: 'PD',          text: 'Public Domain' }
        { id: 'CopyrightAR', text: 'Copyright All Rights Reserved' }
        { id: 'CC-BY',       text: 'CreativeCommons - Attribution CC BY' }
        { id: 'CC-BY-SA',    text: 'CreativeCommons - Attribution-ShareAlike CC BY-SA' }
        { id: 'CC-BY-ND',    text: 'CreativeCommons - Attribution-NoDerivs CC BY-ND' }
        { id: 'CC-BY-NC',    text: 'CreativeCommons - Attribution-NonCommercial CC BY-NC' }
        { id: 'CC-BY-NC-ND', text: 'CreativeCommons - Attribution-NonCommercial-NoDerivs CC BY-NC-ND' }
        { id: 'CC-BY-ND-SA', text: 'CreativeCommons - Attribution-NonCommercial-ShareAlike CC BY-ND-SA' }

      ]

      imageSelects.getSelectOptions = (select) ->
        selects[select]

      imageSelects