class MessagesController < ApplicationController
  respond_to :json

  def create
    current_user.heartbeat!

    room = Room.find params[:room_id]
    message = room.messages.new(
      username: current_user.name,
      type: :text,
      data: params[:message]
    )

    processor = CommandProcessor.new(self)
    message = processor.process(message)

    if message.save
      Pusher[room.channel].trigger! :receive_message, message.to_json
      render :json => message, :status => :created
    else
      respond_with(message.errors, :status => :unprocessable_entity)
    end
  end
end
