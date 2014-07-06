class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
    end

    Game.all.each do |game|
      Channel.create(name: game.name)
    end
  end
end
