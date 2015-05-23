class UserChannel < ActiveRecord::Base
  belongs_to :channel
  belongs_to :user

  def activate
    if user.current_channel.try(:id) == id
      true
    else
      user.current_channel.try(:deactivate)
      update_attributes(active: true)
    end
  end

  def deactivate
    update_attributes(active: false)
  end
end
