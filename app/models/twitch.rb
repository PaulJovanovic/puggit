module Twitch
  CLIENT_ID = "hd3b0rf8j1mlqwqwoqb9wvopccmvb8f"
  BASE_URL = "https://api.twitch.tv/kraken"

  def self.crawl
    Twitch.crawl_games
  end

  def self.crawl_games
    total = 0
    limit = 100
    offset = 0
    while offset == 0 || limit + offset < total do
      response = Twitch.get_games(limit, offset)
      total = response["_total"]
      offset += limit
      response["top"].each do |game|
        game =  Game.where(twitch_id: "#{game["game"]["_id"]}").last || Game.create(name: game["game"]["name"], twitch_id: game["game"]["_id"])
        crawl_streams(game)
      end
    end
  end

  def self.crawl_streams(game)
    total = 0
    limit = 100
    offset = 0
    while offset == 0 || limit + offset < total do
      response = Twitch.search_streams(game.name, limit, offset)
      total = response["_total"]
      offset += limit
      response["streams"].each do |stream|
        streamer = Streamer.where(twitch_id: "#{stream["channel"]["_id"]}").last || Streamer.create(name: stream["channel"]["display_name"], twitch_id: stream["channel"]["_id"], language: stream["channel"]["language"])
        streamer.played(game)
      end
    end
  end

  def self.get_games(limit, offset)
    HTTParty.get("#{BASE_URL}/games/top?client_id=#{CLIENT_ID}&limit=#{limit}&offset=#{offset}")
  end

  def self.search_streams(query, limit, offset)
    HTTParty.get("#{BASE_URL}/search/streams?client_id=#{CLIENT_ID}&q=#{URI.encode(query)}&limit=#{limit}&offset=#{offset}")
  end
end
