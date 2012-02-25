class window.MessageFormView extends Backbone.View
  events:
    'keypress textarea': 'monitorKeyPress'
    'submit form': 'sendMessage'
    'ajax:beforeSend form': 'startSending'
    'ajax:complete form': 'messageSent'

  monitorKeyPress: (e) ->
    ($ @el).find('form').submit() if e.which == 13 and not e.shiftKey

  sendMessage: ->
    # validate input here

  startSending: ->
    ($ @el).find('input[type=submit]').attr('disabled', 'disabled')

  messageSent: ->
    ($ @el).find('textarea').val('')

