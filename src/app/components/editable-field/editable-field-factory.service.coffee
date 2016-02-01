angular.module "imagewikiFrontend"
  .factory 'EditableFieldFactory', [
    '$filter'
    'ImageSelects'
    ($filter, ImageSelects) ->
      editableFieldFactory = {}

      editableFieldFactory.notChanged = (name, initial, model) ->
        switch name
          when 'license_type_id'
            angular.equals(initial.text, model)
          else
            angular.equals(initial, model)

      editableFieldFactory.formatInitialValue = (name, value) ->
        switch name
          when 'license_type_id'
            values = ImageSelects.getSelectOptions(name)
            $filter('filter')(values, {text:value})[0]
          else
            value

      editableFieldFactory.formatValue = (name, value) ->
        return '' unless value?
        switch name
          when 'license_type_id'
            value.id
          else
            value

      editableFieldFactory.formatLabel = (type, name, value) ->
        return '' unless value?

        if name == 'license_type_id'
          if angular.isObject(value)
            return value.text
          else
            return value


        switch type
          when 'boolean'
            if value then 'YES' else 'NO'
          when 'date'
            moment(value).format('DD/MM/YYYY')
          when 'array'
            value.join(', ')
          else
            value

      editableFieldFactory
  ]