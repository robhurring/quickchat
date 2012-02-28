class window.RoomNameView extends Backbone.View
  initialize: ->
    _.bindAll @, 'render'
    @model.bind 'change', @render

  render: ->
    @.$el.find('p').text @model.get('topic')
    this

