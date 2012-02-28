class window.UserView extends Backbone.View
  tagName: 'li'

  initialize: ->
    @template = Templates['user']

  render: ->
    @.$el.attr('data-id', @model.id)
    @.$el.html(@model.get('name'))
    this