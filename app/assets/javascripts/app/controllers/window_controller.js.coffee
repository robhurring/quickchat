class window.WindowController
  constructor: ->
    _.bindAll @, 'updateCount'

    @unreadMessages = 0
    @title = ($ 'title').text()
    @focus = true
    ($ window).on 'focus', @gainedFocus
    ($ window).on 'blur', @lostFocus
    chatController.messages.bind 'add', @updateCount

  updateCount: =>
    unless @focus
      @unreadMessages += 1
      ($ 'title').text "#{@title} [#{@unreadMessages}]"

  gainedFocus: =>
    @focus = true
    @unreadMessages = 0
    ($ 'title').text(@title)

  lostFocus: =>
    @focus = false
