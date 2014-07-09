class StreamsController < ApplicationController
  def search
    streams_response = HTTParty.get("https://api.twitch.tv/kraken/streams?game=#{URI.encode(params[:query])}&limit=100")
    streams = {}
    streams_response["streams"].each do |stream|
      streams[stream["channel"]["name"]] = { display_name: stream["channel"]["display_name"], status: stream["channel"]["status"], logo: stream["channel"]["logo"] }
    end
    render json: streams
  end

  def status

    stream_response = HTTParty.get("https://api.twitch.tv/kraken/streams/#{params[:name]}")
    if stream_response["stream"] != nil
      render json: { online: true }, status: 200
    else
      binding.pry
      render json: { online: false }, status: :unprocessible_entity
    end
  end
end
