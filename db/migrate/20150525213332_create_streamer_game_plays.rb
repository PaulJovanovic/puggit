class CreateStreamerGamePlays < ActiveRecord::Migration
  def change
    create_table :streamer_game_plays do |t|
      t.integer :streamer_game_id
      t.timestamps
    end

    add_index :streamer_game_plays, :streamer_game_id
  end
end
