class AddPlayCountToStreamerGames < ActiveRecord::Migration
  def change
    add_column :streamer_games, :streamer_game_plays_count, :integer, default: 0
  end
end
