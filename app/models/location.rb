class Location < ActiveRecord::Base
  has_many :photos
  geocoded_by :address
  validates :city, presence: true
  validates :state, presence: true
  validates :insta_id, presence: true
  validates :popularity, presence: true, numericality: true
  validates :name, uniqueness: { scope: [:latitude, :longitude] }
  after_validation :geocode, :reverse_geocode

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
      if Time.now - Time.at(media["created_time"].to_i) < 604800
        db_photo = Photo.where(link: media["link"]).first
        if db_photo.nil?
          Photo.create(
            location: self,
            link: media["link"],
            low_res_link: media["images"]["low_resolution"]["url"],
            created_on_insta: media["created_time"].to_i,
            caption: media["caption"]["text"],
            username: media["user"]["username"],
            profile_picture: media["user"]["profile_picture"],
            likes: media["likes"]["count"].to_i,
            comments: media["comments"]["count"].to_i,
            popularity: media["likes"]["count"].to_i +
             media["comments"]["count"].to_i
          )
        elsif db_photo.popularity != media["likes"]["count"].to_i +
            media["comments"]["count"].to_i || db_photo.caption !=
                media["caption"]["text"] || db_photo.username !=
                    media["user"]["username"] || db_photo.profile_picture !=
                        media["user"]["profile_picture"]
          photo = Photo.where(link: media["link"]).first
          photo.update_attributes(
            caption: media["caption"]["text"],
            username: media["user"]["username"],
            profile_picture: media["user"]["profile_picture"],
            likes: media["likes"]["count"].to_i,
            comments: media["comments"]["count"].to_i,
            popularity: media["likes"]["count"].to_i +
             media["comments"]["count"].to_i
          )
        end
      end
    end
  end

  def update_location_popularity
    popularity_count = 0
    photos = self.photos.where("created_on_insta > ?", (Time.now - 604800).to_i)
    photos.each do |photo|
      popularity_count += photo.popularity
    end
    self.update_attribute(:popularity, popularity_count)
  end
end
