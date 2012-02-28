require 'oembed'

CommandProcessor.setup do
  action :rename do |new_name|
    current_user.update_attribute :name, new_name
  end

  listen ::OEmbed.regex do |url, host|
    set_type :oembed
  end

  listen %r{^https?:\/\/(.+)(gif|jpe?g|png)$} do |url, type|
    set_type :image
  end

  listen %r{[\n]+} do |message|
    set_type :paste
  end

  listen %r{^/play (.+)} do |message, sound|
    set_type :sound
    set_data sound
  end

  listen %r{^/rename (.+)} do |data, new_name|
    old_name = current_user.name
    rename new_name

    set_type :command
    set_data "#{old_name} renamed to #{new_name}"

    pusher.trigger! :renamed_user, current_user.to_json
  end
end

