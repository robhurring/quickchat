class MessagesController < ApplicationController
  respond_to :json

  def create
    room = Room.find(params[:room_id])
    command = Commands.process params[:message]

    # TODO: refactor this
    case command.type
    when :rename
      old_name = current_user.name
      current_user.update_attribute :name, command.data
      command.data = %{"#{old_name}" is now known as "#{current_user.name}"}
      command.type = :command
    end

    @message = room.messages.new(
      username: current_user.name,
      type: command.type,
      data: command.data
    )

    if @message.save
      Pusher[room.channel].trigger!('receive_message', @message.to_json)
      render :json => @message, :status => :created
    else
      respond_with(@message.errors, :status => :unprocessable_entity)
    end
  end
end
