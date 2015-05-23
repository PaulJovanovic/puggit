class UserChannelsController < ApplicationController
  def create
    @user_channel = UserChannel.new(user_id: current_user.id, channel_id: params[:channel_id])

    if @user_channel.save
      render json: { id: @user_channel.id, channel: { id: @user_channel.channel_id, name: @user_channel.channel.name } }
    else
      render json: { errors: @user_channel.errors }, status: :unprocessible_entity
    end
  end

  def destroy
    @user_channel = UserChannel.where(user_id: current_user.id, id: params[:id]).last
    @user_channel.destroy
    render json: { id: @user_channel.id }
  end

  def activate
    @user_channel = UserChannel.where(user_id: current_user.id, id: params[:id]).last

    if @user_channel.activate
      render json: { id: @user_channel.id }
    else
      render json: { errors: @user_channel.errors }, status: :unprocessible_entity
    end
  end
end
