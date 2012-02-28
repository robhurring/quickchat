#= require underscore
#= require backbone
#= require handlebars
#= require jquery.scrollto
#= require jquery.oembed.min
#= require_tree .

# Pusher.log = (message) ->
#     console.log message

# WEB_SOCKET_DEBUG = true;

$ ->
  $.scrollTo.defaults.axis = 'y'

  # pickup our templates
  window.Templates = {}
  ($ 'script[data-template]').each (i, el) ->
    $this = ($ this)
    Templates[$this.data('template')] = Handlebars.compile($this.html().trim())

  Pusher.channel_auth_endpoint = PUSHER_AUTH_ENDPOINT;
  window.chatController = new ChatController PUSHER_KEY, RoomData
  window.windowController = new WindowController()
  ($ window).resize chatController.chatView.resize
  chatController.chatView.resize()