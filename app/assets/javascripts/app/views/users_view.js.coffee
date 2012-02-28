class window.UsersView extends Backbone.View
  initialize: ->
    _.bindAll @, 'removeUser', 'addUser', 'render'
    @collection.bind 'add', @addUser
    @collection.bind 'remove', @removeUser
    @collection.bind 'reset', @render

  removeUser: (user) ->
    console.log 'remove', user
    console.log user.id
    ($ "[data-id=#{user.id}]").remove()

  addUser: (user) ->
    @.$el.append new UserView(model: user).render().el

  render: ->
    @collection.forEach (user) =>
      @addUser user

    this