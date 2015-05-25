class CreateStreamerGames < ActiveRecord::Migration
  def change
    create_table :streamer_games do |t|
      t.integer :streamer_id
      t.integer :game_id
      t.timestamps
    end
  end
end
