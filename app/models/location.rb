class Location < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  validates :name, uniqueness: { scope: [:latitude, :longitude] }
  after_validation :reverse_geocode

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    geo = results.first
    obj.street = geo.address_data["addressLine"]
    obj.city = geo.city
    obj.state = geo.state
  end

  def address
    [street, city, state].compact.join(', ')
  end

  def address_changed?
    attrs = %w(street city state)
    attrs.any?{|a| send "#{a}_changed?"}
  end
end
