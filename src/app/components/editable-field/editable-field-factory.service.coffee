angular.module "imagewikiFrontend"
  .factory 'EditableFieldFactory', [
    '$filter'
    'ImageSelects'
    'PbrSelectModel'
    ($filter, ImageSelects, PbrSelectModel) ->
      editableFieldFactory = {}

      cleanArray = (value) ->
        value.filter (v) ->
          v != null

      editableFieldFactory.notChanged = (name, initial, model) ->
        switch name
          when 'license_type_id'
            return true unless initial?
            angular.equals(initial.text, model)
          when 'platform_business_rules.all'
            PbrSelectModel.notChanged(name, initial, model)
          when 'keywords'
            angular.equals(initial, cleanArray(model))
          else
            angular.equals(initial, model)

      editableFieldFactory.formatInitialValue = (name, value) ->
        switch name
          when 'license_type_id'
            values = ImageSelects.getSelectOptions(name)
            $filter('filter')(values, {text:value})[0]
          when 'platform_business_rules.all'
            PbrSelectModel.formatInitialValue(name, value)
          when 'keywords'
            cleanArray value
          else
            value

      editableFieldFactory.formatValue = (name, value, originalValue) ->
        return '' unless value?
        switch name
          when 'license_type_id'
            value.id
          when 'platform_business_rules.all'
            PbrSelectModel.formatValue(name, value, originalValue)
          else
            value

      editableFieldFactory.formatLabel = (type, name, value) ->
        return '' unless value?

        if name == 'license_type_id'
          if angular.isObject(value)
            return value.text
          else
            return value

        if name == 'platform_business_rules.all'
          return PbrSelectModel.formatLabel(name, value)

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