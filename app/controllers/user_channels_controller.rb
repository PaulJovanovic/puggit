class UserChannelsController < ApplicationController
  def create
    @user_channel = UserChannel.new(user_id: current_user.id, channel_id: params[:channel_id])

    if @user_channel.save
      render json: { id: @user_channel.id }
    else
      render json: { errors: @user_channel.errors }, status: :unprocessible_entity
    end
  end
end
