class window.MessageView extends Backbone.View
  className: 'chat-message row-fluid'

  initialize: ->
    @template = Handlebars.compile ($ 'script[name=chat-message]').html().trim()

  render: ->
    ($ @el).html @template(@model.toJSON())
    this