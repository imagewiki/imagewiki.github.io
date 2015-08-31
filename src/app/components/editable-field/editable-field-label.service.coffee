angular.module "imagewikiFrontend"
  .factory 'EditableFieldLabel',
    ->
      editableFieldLabel = {}

      editableFieldLabel.formatLabel = (type, value) ->
        return '' unless value?
        if type == 'boolean'
          if value then 'YES' else 'NO'
        else if type == 'date'
          date = new Date(value)
          date.toLocaleString()
        else
          value

      editableFieldLabel