class UserChannel < ActiveRecord::Base
  belongs_to :channel
  belongs_to :user

  def activate
    user.current_channel.try(:deactivate)
    update_attributes(active: true)
  end

  def deactivate
    update_attributes(active: false)
  end
end
