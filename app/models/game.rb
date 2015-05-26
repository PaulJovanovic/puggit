class Game < ActiveRecord::Base
  has_one :channel, as: :channelable
  has_many :streamer_games, dependent: :destroy

  validates :name, uniqueness: true

  after_create :create_channel

  def current_streamers
    streamer_games.where("updated_at > ?", 2.hours.ago)
  end

  def has_current_streamers?
    current_streamers.any?
  end

  private

  def create_channel
    Channel.create(channelable_type: "Game", channelable_id: id, name: name)
  end
end
