angular.module "imagewikiFrontend"
  .factory 'PbrSelectModel', [
    '$q'
    '$filter'
    ($q, $filter) ->
      options = [
        { id: 'block',        text: 'Block' }
        { id: 'allow',        text: 'Allow' }
        { id: 'allow_w_attr', text: 'Allow with Attribution' }
        { id: 'ad_rev_share', text: 'Ad Rev Share License' }
      ]

      platform = (name) ->
        name.split('.')[1]

      platformRule = (rules, name) ->
        formatedRule = ''
        quit = false
        for rule in rules
          for key, value of rule
            if key == platform(name)
              formatedRule = rule
              quit = true
          break if quit
        formatedRule

      optionRule = (name, rule) ->
        $filter('filter')(options, {id: rule[platform(name)]})[0]

      formatRule = (name, value) ->
        newRule = {}
        newRule[platform(name)] = value.id
        newRule

      pbrSelectModel = {}

      pbrSelectModel.options = options

      pbrSelectModel.notChanged = (name, initial, model) ->
        angular.equals initial, pbrSelectModel.formatInitialValue(name, model)

      pbrSelectModel.formatInitialValue = (name, value) ->
        return { id: '', text: '' } if value == null

        rule = platformRule(value, name)
        formated = optionRule name, rule
        formated

      pbrSelectModel.formatValue = (name, value, originalValue) ->
        newRules      = []
        originalValue = [] if originalValue == null

        if originalValue.length == 0
          newRules.push formatRule(name, value)
        else
          for rule in originalValue
            for k, v of rule
              if k == platform(name)
                newRules.push formatRule(name, value)
              else
                newRules.push rule
        newRules

      pbrSelectModel.formatLabel = (name, value) ->
        if value.id?
          rule = value
        else
          rule = pbrSelectModel.formatInitialValue(name, value)
        rule.text

      pbrSelectModel
  ]
