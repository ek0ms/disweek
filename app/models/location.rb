class Location < ActiveRecord::Base
  has_many :photos
  geocoded_by :address
  after_validation :geocode
  validates :name, uniqueness: { scope: [:latitude, :longitude] }
  after_validation :reverse_geocode

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    obj.street = geo.address_data["addressLine"]
    obj.city = geo.city
    obj.state = geo.state
  end

  def address
    [street, city, state].compact.join(', ')
  end

  def photos_uri
    URI("https://api.instagram.com/v1/locations/#{insta_id}/media/recent?access_token=393459182.5550f72.40571a65e1074b8f95e17a89146768e3")
  end

  def create_photos
    response = Net::HTTP.get_response(photos_uri)
    body = JSON.parse(response.body)["data"]
    body.each do |media|
      Photo.create(
      location: self,
      link: media["link"],
      low_res_link: media["images"]["low_resolution"]["url"],
      created_on_insta: media["created_time"],
      caption: media["caption"]["text"],
      username: media["user"]["username"],
      profile_picture: media["user"]["profile_picture"],
      likes: media["likes"]["count"].to_i,
      comments: media["comments"]["count"].to_i
      )
    end
  end
end
