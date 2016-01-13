angular.module "imagewikiFrontend"
  .factory 'EditableFieldLabel',
    ->
      editableFieldLabel = {}

      editableFieldLabel.formatLabel = (type, value) ->
        return '' unless value?
        switch type
          when 'boolean'
            if value then 'YES' else 'NO'
          when 'date'
            moment(value).format('DD/MM/YYYY')
          when 'array'
            value.join(', ')
          else
            value

      editableFieldLabel