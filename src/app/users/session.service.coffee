angular.module "imagewikiFrontend"
  .service 'Session', ->

    @create = (sessionId, userId, userRole) ->
      @id = sessionId
      @userId = userId
      @userRole = userRole
      return

    @destroy = ->
      @id = null
      @userId = null
      @userRole = null
      return

    return