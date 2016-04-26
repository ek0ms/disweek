class UserPhoto < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo

  validates :id, uniqueness: { scope: [:user_id, :photo_id] }
end
