class window.MessageView extends Backbone.View
  className: "chat-message row-fluid"

  initialize: ->
    type = @model.get('type')
    @template = Templates[type] || Templates['default']

  render: ->
    @.$el.addClass(@model.get('type')).html(@template(@model.toJSON()))
    this