class TheatresController < ApplicationController
  def show
    @user_channels = current_user.user_channels.includes(:channel).order("created_at desc")
  end
end
