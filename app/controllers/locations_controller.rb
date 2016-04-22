class LocationsController < ApplicationController
  def index
    if params[:search].present?
      create_locations_from_coordinates
    else
      @locations = Location.near(params[:search], 50, order: :distance)
      @locations = Location.all
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def get_places
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)["data"]
  end

  def uri
    URI("https://api.instagram.com/v1/locations/search?lat=#{@lat}&lng=#{@lng}&distance=750&access_token=393459182.5550f72.40571a65e1074b8f95e17a89146768e3")
  end

  def create_locations_from_coordinates
    address = params[:search].split(", ")
    current_location = Location.new(
      street: address[0],
      city: address[1],
      state: address[2]
    )
    @lat = current_location.geocode[0]
    @lng = current_location.geocode[1]
    @places = get_places
    @places.each do |place|
      if Location.where(insta_id: place["id"]).empty?
        if place["id"] != "0"
          new_place = Location.new(
            latitude: place["latitude"],
            longitude: place["longitude"]
          )
          new_place.reverse_geocode
          new_place.name = place["name"]
          new_place.insta_id = place["id"]
          new_place.save
        end
      end
    end
  end
end
