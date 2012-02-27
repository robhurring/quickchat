class window.ChatController
  constructor: (@pusher_key, @data) ->
    @connect()
    @messages = new Messages @data.messages
    @chatView = new ChatView collection: @messages, el: ($ '#chat')
    @windowView = new WindowView @messages
    @messageFormView = new MessageFormView el: ($ '#message-form')

    @users = []
    @loadViews()

  connect: ->
    @pusher = new Pusher @pusher_key
    @channel = @pusher.subscribe "presence-#{@data._id}"
    @channel.bind 'pusher:subscription_succeeded', @subscribed
    @channel.bind 'pusher:subscription_error', @subscriptionError
    @channel.bind 'pusher:member_added', @userJoined
    @channel.bind 'pusher:member_removed', @userLeft
    @channel.bind 'receive_message', @receiveMessage

  loadViews: ->
    @chatView.render()

  receiveMessage: (data) =>
    @messages.add new Message(data)

  changeTopic: (data) =>
    console.log 'Change Topic', data

  subscriptionError: (data) =>
    console.log 'Oh shit. Error'

  subscribed: (data) =>
    ($ '#connection-alert').fadeOut('slow')

  userJoined: (data) =>
    console.log 'User Joined', data

  userLeft: (data) =>
    console.log 'User Left', data
