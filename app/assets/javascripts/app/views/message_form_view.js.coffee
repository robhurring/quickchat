class window.MessageFormView extends Backbone.View
  events:
    'keypress textarea': 'monitorKeyPress'
    'submit form': 'sendMessage'
    'ajax:beforeSend form': 'startSending'
    'ajax:complete form': 'messageSent'

  initialize: ->
    @errorMessage = ($ '#error-message')
    @submitButton = ($ @el).find('button[type=submit]')
    @textarea = ($ @el).find('textarea')

  setError: (message) ->
    @errorMessage.html(message)
    @errorMessage.parent().fadeIn()
    @submitButton.addClass 'btn-danger'
    ($ @el).find('.control-group').addClass 'error'

  clearError: ->
    @errorMessage.parent().fadeOut()
    @submitButton.removeClass 'btn-danger'
    ($ @el).find('.control-group').removeClass 'error'

  monitorKeyPress: (e) ->
    if e.which == 13 and not e.shiftKey
      e.preventDefault() # stop the line from breaking
      ($ @el).find('form').submit()

  sendMessage: (e) ->
    if @textarea.val() == ''
      @setError 'Please enter something to say'
      false

  startSending: ->
    @submitButton.addClass 'disabled'
    @textarea.attr 'readonly', 'readonly'

  messageSent: ->
    @clearError()
    @submitButton.removeClass 'disabled'
    @textarea.val ''
    @textarea.removeAttr 'readonly'

