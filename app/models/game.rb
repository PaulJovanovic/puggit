class Game < ActiveRecord::Base
  has_one :channel, as: :channelable

  validates :name, uniqueness: true

  def self.sync_with_twitch
    total = 0
    limit = 100
    offset = 0
    while total == 0 || limit + offset < total do
      game_list = HTTParty.get("https://api.twitch.tv/kraken/games/top?limit=#{limit}&offset=#{offset}")
      total = game_list["_total"]
      offset += limit
      game_list["top"].each do |game|
        if Game.where(twitch_id: game["game"]["_id"]).count == 0
          Game.create(name: game["game"]["name"], twitch_id: game["game"]["_id"])
        end
      end
    end
  end
end
