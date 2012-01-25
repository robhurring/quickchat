class RoomsController < ApplicationController
  respond_to :html

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
end
