class Channel < ActiveRecord::Base
  belongs_to :channelable, polymorphic: true

  validates :name, uniqueness: true

  def self.search_by_name(name)
    where('lower(name) LIKE ?', "#{name.downcase}%")
  end
end
