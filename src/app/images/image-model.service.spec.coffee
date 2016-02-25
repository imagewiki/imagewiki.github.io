describe 'ImageModel Service', ->
  $httpBackend = undefined
  API_URL      = undefined
  ImageModel   = undefined

  beforeEach module('imagewikiFrontend')
  beforeEach inject((_$httpBackend_, _API_URL_, _ImageModel_) ->
    $httpBackend = _$httpBackend_
    ImageModel   = _ImageModel_
    API_URL      = _API_URL_

    jasmine.getJSONFixtures().fixturesPath = 'base/app/fixtures'

    return
  )

  describe 'getGreeting', ->
    it 'says Hello to me', ->
      expect(ImageModel.getGreeting('Dave')).toEqual 'Hello Dave'
      return
    return

  describe 'getImage', ->
    it 'get image info with image hashid', ->
      hashid = 'ejxro3m74392'

      imageJson = getJSONFixture('image.json')

      # $httpBackend.expectGET("#{API_URL}/images/#{hashid}?includeFields=all").respond(200, imageJson)

      console.log '================= GET IMAGE =========================='
      console.log API_URL
      console.log imageJson

      # ImageModel.getImage(hashid).then (data) ->
      #   console.log '==========================================='
      #   console.log data
      #   console.log '==========================================='
      #   console.log imageJson
      #   console.log '==========================================='
      #   # expect(data).toEqual imageJson
      #   return
      # $httpBackend.flush()
      return
    return

  return