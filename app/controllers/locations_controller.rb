class LocationsController < ApplicationController
  def index
    if params[:search] == "Current Location"
      @current_search = []
      create_locations_from_ip
      @ordered_search = Location.where(id: @current_search.map(&:id)).order(
        popularity: :desc)
    elsif params[:search].present?
      @current_search = []
      create_locations_from_address
      @ordered_search = Location.where(id: @current_search.map(&:id)).order(
        popularity: :desc)
    else
      @ordered_search = []
    end
  end

  def show
    @location = Location.find(params[:id])
    @photos = @location.photos.where("created_on_insta > ?", (Time.now -
     604800).to_i).order(popularity: :desc)
     @photo = UserPhoto.new
  end

  def get_places
    response = Net::HTTP.get_response(places_uri)
    JSON.parse(response.body)["data"]
  end

  def places_uri
    URI("https://api.instagram.com/v1/locations/search?lat=#{@lat}&lng=#{@lng}&distance=750&access_token=393459182.5550f72.40571a65e1074b8f95e17a89146768e3")
  end

  def create_locations_from_address
    address = params[:search].split(", ")
    current_location = Location.new(
      street: address[0],
      city: address[1],
      state: address[2]
    )

    @lat = current_location.geocode[0]
    @lng = current_location.geocode[1]
    create_locations
  end

  def create_locations_from_ip
    if Rails.env.test? || Rails.env.development?
      current_location ||= Geocoder.search("50.78.167.161").first
    else
      current_location ||= request.location
    end
    @lat = current_location.data["latitude"]
    @lng = current_location.data["longitude"]
    create_locations
  end

  def create_locations
    @places = get_places
    @places.each do |place|
      if Location.where(insta_id: place["id"]).empty? && place["id"] != "0"
        new_place = Location.new(
          latitude: place["latitude"],
          longitude: place["longitude"]
        )
        new_place.reverse_geocode
        new_place.name = place["name"]
        new_place.insta_id = place["id"]
        new_place.save
        if !new_place.create_photos.empty?
          new_place.update_location_popularity
        end
        @current_search << new_place
      elsif !Location.where(insta_id: place["id"]).empty? && place["id"] != "0"
        old_place = Location.where(insta_id: place["id"]).first
        if !old_place.create_photos.empty?
          old_place.update_location_popularity
        end
        @current_search << old_place
      end
    end
  end
end
