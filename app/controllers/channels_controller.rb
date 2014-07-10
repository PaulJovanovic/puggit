class ChannelsController < ApplicationController
  def create
    @channel = Channel.new(channel_params)

    if @channel.save
      render json: { id: @channel.id, name: @channel.name }
    else
      render json: { errors: @channel.errors }
    end
  end

  def search
    channels = Channel.search_by_name(params[:query].strip())
    if current_user.channels.count > 0
      channels = channels.where('id not in (?)', current_user.channels.map(&:id))
    end
    render json: channels.map { |channel| { id: channel.id, name: channel.name } }
  end

  private

  def channel_params
    params.require(:channel).permit(:name)
  end
end
