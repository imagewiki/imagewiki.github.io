angular.module "imagewikiFrontend"
  .filter 'fullTitle', ->
    (input) ->
      base = 'Imagewiki - Find Ownership information for Images'
      base + (if input? then " | #{input}" else ' | The world\'s photo content id database')