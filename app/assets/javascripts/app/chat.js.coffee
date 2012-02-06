class window.Chat
  constructor: (@pusher_key, @data) ->
    @connect()
    @room = new Room @data

  connect: ->
    @pusher = new Pusher @pusher_key