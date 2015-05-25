class CreateStreamers < ActiveRecord::Migration
  def change
    create_table :streamers do |t|
      t.integer :twitch_id
      t.string :name
      t.string :language
      t.timestamps
    end

    add_index :streamers, :twitch_id, unique: true
    add_index :streamers, :name, unique: true
  end
end
