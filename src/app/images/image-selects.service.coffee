angular.module "imagewikiFrontend"
  .factory 'ImageSelects',
    ->
      imageSelects = {}

      selects = {}
      selects.cc_license_type = [
        'Attribution (CC BY)'
        'Attribution Sharealike (CC BY-SA)'
        'Attribution-NoDerivs (CC BY-ND)'
        'Attribution-NonCommercial (CC BY-NC)'
        'Attribution-NonCommercial-ShareAlike (CC BY-NC-SA)'
        'Attribution-NonCommercial-NoDerivs (CC BY-NC-ND)'
      ]
      selects.license_type = [
        'Rights Managed (RM)'
        'Royalty Free (RF)'
      ]

      imageSelects.getSelectOptions = (select) ->
        selects[select]

      imageSelects