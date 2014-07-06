class Game < ActiveRecord::Base
  has_one :channel, as: :channelable

  validates :name, uniqueness: true
end
