class Channel < ActiveRecord::Base
  belongs_to :channelable, polymorphic: true

  has_many :user_channels
  has_many :users, :through => :user_channels

  validates :name, uniqueness: true

  def self.search_by_name(name)
    where('lower(name) LIKE ?', "#{name.downcase}%")
  end
end
