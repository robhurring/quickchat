#= require underscore
#= require backbone
#= require handlebars
#= require_tree .

# Pusher.log = (message) ->
#     console.log message

# WEB_SOCKET_DEBUG = true;

Handlebars.registerHelper 'emojify', (text) ->
  text.replace /:[a-z0-9\-\+]+:/i, (emoji_symbol) ->
    emoji = emoji_symbol[1...-1]
    "<span class='emoji emoji-#{emoji}' title='#{emoji_symbol}'></span>"

$ ->
  Pusher.channel_auth_endpoint = PUSHER_AUTH_ENDPOINT;
  window.chat_controller = new ChatController PUSHER_KEY, RoomData
  ($ window).resize chat_controller.chatView.resize
  chat_controller.chatView.resize()