angular.module "imagewikiFrontend"
  .factory 'MatchModel', ->
    imageResults = []
    matchModel    = {}

    matchModel.setResults = (results) ->
      imageResults = results
      return

    matchModel.getResults = ->
      imageResults

    matchModel
