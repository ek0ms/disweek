class Photo < ActiveRecord::Base
  belongs_to :location
  has_many :user_photos
  has_many :users, through: :user_photos

  validates :link, presence: true
  validates :low_res_link, presence: true
  validates :created_on_insta, presence: true, uniqueness: true,
  numericality: true
  validates :username, presence: true
  validates :profile_picture, presence: true
  validates :caption, presence: true
  validates :likes, presence: true, numericality: true
  validates :comments, presence: true, numericality: true
  validates :popularity, presence: true, numericality: true
end
