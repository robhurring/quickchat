class window.ChatView extends Backbone.View
  MESSAGES_TO_KEEP = 5

  initialize: ->
    _.bindAll @, 'render', 'appendMessage', 'resize', 'scrollToBottom'
    @collection.on 'reset', @render
    @collection.on 'remove', @removeMessage
    @collection.on 'add', @appendMessage
    @collection.on 'add', @scrollToBottom
    @collection.on 'add', @oembed
    @collection.on 'reset', @oembed

  oembed: ->
    self = @
    ($ '.oembed .data').each (i, el) ->
      $this = ($ this)
      $this.oembed $this.data('url'),
        beforeEmbed: ->
          $this.addClass 'embedding'
        afterEmbed: ->
          self.scrollToBottom()
          $this.removeClass 'embedding'
          $this.addClass 'embedded'
        onError: (url) ->
          console.log "Error embedding: #{url}"

  resize: ->
    messageFormHeight = ($ '#message-form').outerHeight()
    windowHeight = ($ window).outerHeight()
    newHeight = windowHeight - messageFormHeight - ($ @el).offset().top - 60
    @.$el.css height: newHeight
    @scrollToBottom()

  scrollToBottom: ->
    @.$el.scrollTo '100%'

  removeMessage: (message) ->
    ($ ".chat-message[data-id=#{message.id}]").remove()

  appendMessage: (message) ->
    @.$el.append new MessageView(model: message).render().el

  render: ->
    @collection.forEach (message) =>
      @appendMessage message

    @oembed()
    this