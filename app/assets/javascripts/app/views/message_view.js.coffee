class window.MessageView extends Backbone.View
  className: "chat-message row-fluid"

  initialize: ->
    type = @model.get('type')
    @template = Templates[type] || Templates['default']

  render: ->
    @.$el.addClass(@model.get('type')).attr('data-id', @model.get('_id'))
    @.$el.html(@template(@model.toJSON()))
    this