class StreamerGamePlay < ActiveRecord::Base
  belongs_to :streamer_game, counter_cache: true
end
