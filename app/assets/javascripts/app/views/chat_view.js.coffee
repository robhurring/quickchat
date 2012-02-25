class window.ChatView extends Backbone.View
  className: 'chat-messages'

  initialize: ->
    _.bindAll @, 'render', 'resize', 'setScroll'
    @collection.on 'reset', @render
    @collection.on 'add', @render

  resize: ->
    messageFormHeight = ($ '#message-form').outerHeight()
    windowHeight = ($ window).outerHeight()
    newHeight = windowHeight - messageFormHeight - ($ @el).offset().top - 60
    ($ @el).css height: newHeight
    @setScroll()

  setScroll: ->
    ($ window).scrollTop(0)
    ($ @el).scrollTop(@el.scrollHeight)

  render: ->
    $el = ($ @el)
    $el.html ''
    @collection.forEach (message) ->
      $el.append new MessageView(model: message).render().el

    @el = $el[0]
    @resize()
    this