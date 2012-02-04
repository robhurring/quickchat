class window.Chat
  constructor: (@data) ->
    @connect()

  connect: ->
    @pusher = new Pusher 'b35414373fbe5cd93f3d'