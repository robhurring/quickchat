class window.ChatView extends Backbone.View
  className: 'chat-messages'

  initialize: ->
    @collection.on 'reset', @render
    @collection.on 'add', @render

  render: ->
    $el = ($ @el)
    @collection.forEach (message) ->
      $el.append new MessageView(model: message).render().el

    this