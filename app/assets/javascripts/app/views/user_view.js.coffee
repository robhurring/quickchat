class window.UserView extends Backbone.View
  tagName: 'li'

  initialize: ->
    _.bindAll @, 'updateUser'
    @template = Templates['user']
    @model.bind 'change', @updateUser

  updateUser: ->
    @.$el.text @model.get('name')

  render: ->
    @.$el.attr('data-id', @model.id)
    @.$el.html(@model.get('name'))
    this