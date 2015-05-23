class AddActiveToUserChannels < ActiveRecord::Migration
  def change
    add_column :user_channels, :active, :boolean
  end
end
