class StreamerGame < ActiveRecord::Base
  belongs_to :streamer
  belongs_to :game
  has_many :streamer_game_plays, dependent: :destroy

  def played
    streamer_game_plays.create
  end
end
