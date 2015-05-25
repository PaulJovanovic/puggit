class Streamer < ActiveRecord::Base
  has_one :channel, as: :channelable
  has_many :streamer_games

  after_create :create_channel

  validates :name, uniqueness: true

  def stream_game(game)
    streamer_games.where(game: game).last || streamer_games.create(game: game)
  end

  def played(game)
    stream_game(game).played
  end

  private

  def create_channel
    Channel.create(channelable_type: "Streamer", channelable_id: id, name: name)
  end
end
