class window.UserView extends Backbone.View
  tagName: 'li'

  initialize: ->
    _.bindAll @, 'updateUser', 'removeView'
    @template = Templates['user']
    @model.bind 'change', @updateUser
    @model.collection.bind 'remove', @removeView

  removeView: (user) ->
    @.$el.remove() if user == @model

  updateUser: ->
    @.$el.text @model.get('name')

  render: ->
    @.$el.attr('data-id', @model.id)
    @.$el.addClass 'current-user' if @model.id == CURRENT_USER_ID
    @.$el.html(@model.get('name'))
    this