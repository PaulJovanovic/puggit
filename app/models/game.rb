class Game < ActiveRecord::Base
  has_one :channel, as: :channelable
  has_many :streamer_games

  validates :name, uniqueness: true

  after_create :create_channel

  private

  def create_channel
    Channel.create(channelable_type: "Game", channelable_id: id, name: name)
  end
end
