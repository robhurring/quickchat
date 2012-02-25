#= require underscore
#= require backbone
#= require handlebars
#= require_tree .

# Pusher.log = (message) ->
#     console.log message

# WEB_SOCKET_DEBUG = true;

Handlebars.registerHelper 'friendly', (text) ->
  filters = ['emojify', 'linkify']
  _.each filters, (filter) ->
    text = Handlebars.helpers[filter](text)
  text

Handlebars.registerHelper 'linkify', (text) ->
  url_pattern = /(\b([^"]?https?|ftp|file):\/\/[a-z0-9\+&@#\/%\?=~_|!:,\.;]*[-A-Z0-9+&@#\/%=~_|])/ig

  text.replace url_pattern, (url) ->
    "<a href='#{url}' target='_blank'>#{url}</a>"

Handlebars.registerHelper 'emojify', (text) ->
  text.replace /:[a-z0-9\-\+]+:/i, (emoji_symbol) ->
    emoji = emoji_symbol[1...-1]
    "<span class='emoji emoji-#{emoji}' title='#{emoji_symbol}'></span>"

$ ->
  # pickup our templates
  window.Templates = {}
  ($ 'script[data-template]').each (i, el) ->
    $this = ($ this)
    Templates[$this.data('template')] = Handlebars.compile($this.html().trim())

  Pusher.channel_auth_endpoint = PUSHER_AUTH_ENDPOINT;
  window.chat_controller = new ChatController PUSHER_KEY, RoomData
  ($ window).resize chat_controller.chatView.resize
  chat_controller.chatView.resize()