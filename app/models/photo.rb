class Photo < ActiveRecord::Base
  belongs_to :location
  validates :link, presence: true
  validates :low_res_link, presence: true
  validates :created_on_insta, presence: true, uniqueness: true
  validates :username, presence: true
  validates :profile_picture, presence: true
  validates :caption, presence: true
  validates :likes, presence: true, numericallity: true
  validates :comments, presence: true, numericallity: true
end
