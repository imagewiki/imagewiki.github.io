angular.module "imagewikiFrontend"
  .factory 'ImageSelects',
    ->
      imageSelects = {}

      selects = {}
      selects.license_type_id = [
        'Public Domain'
        'Copyright All Rights Reserved'
        'CreativeCommons - Attribution (CC BY)'
        'CreativeCommons - Attribution Sharealike (CC BY-SA)'
        'CreativeCommons - Attribution-NoDerivs (CC BY-ND)'
        'CreativeCommons - Attribution-NonCommercial (CC BY-NC)'
        'CreativeCommons - Attribution-NonCommercial-NoDerivs (CC BY-NC-ND)'
        'CreativeCommons - Attribution-NonCommercial-ShareAlike (CC BY-NC-SA)'
      ]

      imageSelects.getSelectOptions = (select) ->
        selects[select]

      imageSelects