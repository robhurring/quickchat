class window.ChatView extends Backbone.View
  initialize: ->
    _.bindAll @, 'render', 'appendMessage', 'resize', 'scrollToBottom'
    @collection.on 'reset', @render
    @collection.on 'add', @appendMessage
    @collection.on 'add', @scrollToBottom

  resize: ->
    messageFormHeight = ($ '#message-form').outerHeight()
    windowHeight = ($ window).outerHeight()
    newHeight = windowHeight - messageFormHeight - ($ @el).offset().top - 60
    @.$el.css height: newHeight
    @scrollToBottom()

  scrollToBottom: ->
    @.$el.scrollTo '100%'

  appendMessage: (message) ->
    @.$el.append new MessageView(model: message).render().el

  render: ->
    @collection.forEach (message) =>
      @appendMessage message

    this