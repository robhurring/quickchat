#= require underscore
#= require backbone
#= require handlebars
#= require_tree .

# Pusher.log = (message) ->
#     console.log message

# WEB_SOCKET_DEBUG = true;
$ ->
  Pusher.channel_auth_endpoint = PUSHER_AUTH_ENDPOINT;
  window.chat_controller = new ChatController PUSHER_KEY, RoomData