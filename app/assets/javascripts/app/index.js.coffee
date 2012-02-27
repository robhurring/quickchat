#= require underscore
#= require backbone
#= require handlebars
#= require jquery.scrollto
#= require_tree .

# Pusher.log = (message) ->
#     console.log message

# WEB_SOCKET_DEBUG = true;

Handlebars.registerHelper 'autolink', (text) ->
  filters = ['emojify', 'linkify']
  _.each filters, (filter) ->
    text = Handlebars.helpers[filter](text)
  text

Handlebars.registerHelper 'linkify', (text) ->
  pattern = /((href=(?:'|")?)?(https?:\/\/|\bwww\.)(\S+)(\/(?:\S+))?)/ig

  text.replace pattern, (url) ->
    "<a href='#{url}' target='_blank'>#{url}</a>"

Handlebars.registerHelper 'emojify', (text) ->
  pattern = /:([a-z0-9\+\-_]+):/ig

  text.replace pattern, (emoji_symbol) ->
    emoji = emoji_symbol[1...-1]
    "<span class='emoji emoji-#{emoji}' title='#{emoji_symbol}'></span>"

Handlebars.registerHelper 'imglink', (url) ->
  img = $('<img/>').attr('src', url).load((e) ->
    chatController.chatView.scrollToBottom()
  )

  elem = $("<a href='#{url}' target='_blank'>").html(img)
  elem.html()

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