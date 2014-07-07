class TheatresController < ApplicationController
  def show
    @channels = current_user.channels.order("created_at desc")
  end
end
