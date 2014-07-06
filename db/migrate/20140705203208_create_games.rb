class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :twitch_id
    end

    total = 0
    limit = 100
    offset = 0
    while total == 0 || limit + offset < total do
      game_list = HTTParty.get("https://api.twitch.tv/kraken/games/top?limit=#{limit}&offset=#{offset}")
      total = game_list["_total"]
      offset += limit
      game_list["top"].each do |game|
        Game.create(name: game["game"]["name"], twitch_id: game["game"]["_id"])
      end
    end
  end
end
