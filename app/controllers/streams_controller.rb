class StreamsController < ApplicationController
  def search
    streams_response = HTTParty.get("https://api.twitch.tv/kraken/streams?game=#{URI.encode(params[:query])}&limit=100")
    streams = {}
    streams_response["streams"].each do |stream|
      streams[stream["channel"]["name"]] = { display_name: stream["channel"]["display_name"], status: stream["channel"]["status"] }
    end
    render json: streams
  end
end
