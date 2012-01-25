Pusher.log = (message) -> 
    console.log message

WEB_SOCKET_DEBUG = true;

# Collections

Message = Backbone.Model.extend()
Messages = Backbone.Collection.extend()

window.messages = new Messages()

# Views

MessageView = Backbone.View.extend
  tagName: 'tr'
  className: 'text_message message'
  
  initialize: ->
    @template = ($ 'script[name=chat-message]').html().trim()

  render: ->
    $(@el).html $.mustache(@template, @model.toJSON())
    @

messages.bind 'add', (message) ->
  view = new MessageView {model: message}
  console.log view.render().el
  $('#chat').append view.render().el

# Pusher Bindings

$ ->
  pusher = new Pusher 'b35414373fbe5cd93f3d'
  
  channel = pusher.subscribe '4f204c5dcbe4c380f9000002'
  channel.bind 'message_received', (data) ->
    messages.add new Message(data)