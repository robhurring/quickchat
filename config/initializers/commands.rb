require 'commands'

module Commands
  listen %r{[\n]+} do |message|
    send :paste, message
  end

  listen %r{^https?:\/\/(.+)(gif|jpe?g|png)$} do |url, type|
    send :image, url
  end

  listen %r{^/play (.+)} do |message, sound|
    send :sound, sound
  end

  # catch all commands
  listen %r{^/([a-z]+)\s?(.+)?} do |message, cmd, args|
    command cmd.to_sym, args
  end
end