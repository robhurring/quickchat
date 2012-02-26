class RoomsController < ApplicationController
  respond_to :html, :json
  protect_from_forgery except: :join

  def new
    @room = Room.new
  end

  def create
    @room = Room.create(params[:room])
    respond_with @room
  end

  def show
    @room = Room.find(params[:id])
    respond_with @room
  end

  def join
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
      user_id: 0,
      user_info: {
        name: 'Anonymous'
      }
    })
    render json: response
  end
end
