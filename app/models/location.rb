class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :fb_id, presence: true

  validates_uniqueness_of :fb_id
end
