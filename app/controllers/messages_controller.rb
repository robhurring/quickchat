class MessagesController < ApplicationController
  respond_to :json

  def index
    raise 'bad...'
  end

  def create
    room = Room.find(params[:room_id])
    @message = room.messages.new(params[:message])
    
    if @message.save
      Pusher[room.id].trigger!('message_received', {
        :username => @message.username,
        :data => @message.data
      })
      render :json => @message, :status => :created
    else
      respond_with(@message.errors, :status => :unprocessable_entity)
    end
  end
end
