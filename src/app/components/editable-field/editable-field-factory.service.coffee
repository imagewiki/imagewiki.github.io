angular.module "imagewikiFrontend"
  .factory 'EditableFieldFactory', [
    '$filter'
    'ImageSelects'
    ($filter, ImageSelects) ->
      editableFieldFactory = {}

      cleanArray = (value) ->
        value.filter (v) ->
          v != null

      editableFieldFactory.notChanged = (name, initial, model) ->
        switch name
          when 'license_type_id', 'platform_business_rules'
            return true unless initial?
            angular.equals(initial.text, model)
          when 'keywords'
            angular.equals(initial, cleanArray(model))
          else
            angular.equals(initial, model)

      editableFieldFactory.formatInitialValue = (name, value) ->
        switch name
          when 'license_type_id', 'platform_business_rules'
            values = ImageSelects.getSelectOptions(name)
            $filter('filter')(values, {text:value})[0]
          when 'keywords'
            cleanArray value
          else
            value

      editableFieldFactory.formatValue = (name, value) ->
        return '' unless value?
        switch name
          when 'license_type_id', 'platform_business_rules'
            value.id
          else
            value

      editableFieldFactory.formatLabel = (type, name, value) ->
        return '' unless value?

        if name in ['license_type_id', 'platform_business_rules']
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