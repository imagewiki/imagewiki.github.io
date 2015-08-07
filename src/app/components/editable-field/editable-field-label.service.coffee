angular.module "imagewikiFrontend"
  .factory 'EditableFieldLabel',
    ->
      editableFieldLabel = {}

      editableFieldLabel.formatLabel = (type, value) ->
        return '' unless value?
        if type == 'date'
          date = new Date(value)
          date.toLocaleString()
        else
          value

      editableFieldLabel