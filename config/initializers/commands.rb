require 'oembed'

CommandProcessor.setup do
  action :rename do |new_name|
    current_user.update_attribute :name, new_name
    pusher.trigger! 'user:updated', current_user.to_json
  end

  action :change_topic do |new_topic|
    room.update_attribute :topic, new_topic
    pusher.trigger! 'room:updated', room.to_json
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
    set_data %{#{old_name} is now known as #{new_name}}
  end

  listen %r{^/topic (.+)} do |data, new_topic|
    old_topic = room.topic
    change_topic new_topic

    set_type :command
    set_data %{#{current_user.name} changed the topic from "#{old_topic}" to "#{new_topic}"}
  end
end

