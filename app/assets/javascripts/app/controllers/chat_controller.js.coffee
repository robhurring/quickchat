class window.ChatController
  constructor: (@pusher_key, @data) ->
    @messages = new Messages @data.messages
    @users = new Users @data.users
    @room = new Room name: @data.name, topic: @data.topic

    @chatView = new ChatView el: ($ '#chat'), collection: @messages
    @roomNameView = new RoomNameView el: ($ '#room-name'), model: @room
    @messageFormView = new MessageFormView el: ($ '#message-form')
    @usersView = new UsersView el: ($ '#users'), collection: @users

    @connect()
    @bind()
    @loadViews()

  connect: ->
    @pusher = new Pusher @pusher_key
    @channel = @pusher.subscribe "presence-#{@data._id}"

  bind: =>
    @channel.bind 'pusher:subscription_succeeded', @subscribed
    @channel.bind 'pusher:subscription_error', @subscriptionError
    @channel.bind 'pusher:member_added', @userJoined
    @channel.bind 'pusher:member_removed', @userLeft
    @channel.bind 'message:received', @receiveMessage
    @channel.bind 'user:updated', @updatedUser
    @channel.bind 'room:updated', @updatedRoom

    ($ window).unload (e) ->
      $.ajax url: PUSHER_LEAVE_ENDPOINT, async: false, type: 'POST'

  loadViews: ->
    @chatView.render()
    @usersView.render()

  receiveMessage: (data) =>
    @messages.add new Message(data)

  changeTopic: (data) =>
    console.log 'Change Topic', data

  subscriptionError: (data) =>
    console.log 'Oh shit. Error'

  subscribed: (data) =>
    ($ '#connection-alert').fadeOut('slow')
    data.each (user) =>
      @users.add new User id: user.id, name: user.info.name, current: true

  userJoined: (data) =>
    @users.add new User id: data.id, name: data.info.name

  userLeft: (data) =>
    @users.remove data.id

  updatedUser: (data) =>
    @users.get(data.id).set('name', data.name)

  updatedRoom: (data) =>
    @room.set('topic', data.topic)
