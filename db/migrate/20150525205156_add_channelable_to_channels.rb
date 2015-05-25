class AddChannelableToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :channelable_type, :string
    add_column :channels, :channelable_id, :integer
  end
end
