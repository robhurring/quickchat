class RoomsController < ApplicationController
  respond_to :html, :json
  protect_from_forgery except: :join

  def new
    @room = Room.new
  end

  def create
    @room = Room.create params[:room]
    respond_with @room
  end

  def show
    @room = Room.find params[:id]
    respond_with @room
  end

  def join
    room = Room.find params[:id]
    room.users << current_user
    room.save

    message = room.messages.new(
      username: current_user.name,
      type: :command,
      data: "#{current_user.name} just joined."
    )

    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
      user_id: current_user.id,
      user_info: {
        name: current_user.name
      }
    })

    Pusher[room.channel].trigger! 'message:received', message.to_json

    render json: response
  end

  def leave
    room = Room.find params[:id]
    room.users.delete current_user

    message = room.messages.new(
      username: current_user.name,
      type: :command,
      data: "#{current_user.name} just left."
    )

    Pusher[room.channel].trigger! 'message:received', message.to_json

    render nothing: true, status: :ok
  end
end
