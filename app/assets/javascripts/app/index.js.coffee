#= require underscore
#= require backbone
#= require mustache
#= require_tree .

Pusher.log = (message) ->
    console.log message

WEB_SOCKET_DEBUG = true;

$ ->
  # pusher = new Pusher 'b35414373fbe5cd93f3d'
  window.chat = new Chat RoomData