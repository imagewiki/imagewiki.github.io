describe 'ImageModelService', ->
  ImageModel = undefined
  beforeEach module('imagewikiFrontend')
  beforeEach inject((_ImageModel_) ->
    ImageModel = _ImageModel_
    return
  )
  describe 'getGreeting', ->
    it 'says Hello to me', ->
      expect(ImageModel.getGreeting('Dave')).toEqual 'Hello Dave'
      return
    return
  return