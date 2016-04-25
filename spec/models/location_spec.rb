require 'rails_helper'

describe Location do
  describe "#address" do
    it "prints out full address" do
      location = create(:location)
      expect(location.address).to eq "27 Harrison Ave, Boston, MA"
    end
  end

  describe "#photos_uri" do
    it "returns URI of recent media of the location" do
      location = create(:location)
      expect(location.photos_uri).to be_kind_of(URI)
    end
  end

  describe "#create_photos" do
    it "creates photo objects for the location if not in database" do
      location = create(:location)

      photos_uri = URI("https://api.instagram.com/v1/locations/#{location.insta_id}/media/recent?access_token=393459182.5550f72.40571a65e1074b8f95e17a89146768e3")
      response = Net::HTTP.get_response(photos_uri)
      media_from_location = JSON.parse(response.body)["data"]
      location.create_photos

      expect(location.photos.length).to eq media_from_location.length
    end

    it "updates photo object if it is already in the database" do
      location = create(:location)
      photo = create(:photo, location: location)
      expect(Photo.first.caption).to eq "poofs"

      photos_uri = URI("https://api.instagram.com/v1/locations/#{location.insta_id}/media/recent?access_token=393459182.5550f72.40571a65e1074b8f95e17a89146768e3")
      response = Net::HTTP.get_response(photos_uri)
      media_from_location = JSON.parse(response.body)["data"]
      location.create_photos

      expect(Photo.find(photo).caption).to eq "let's puff"
    end
  end

  describe "#update_location_popularity" do
    it "updates popularity attribute for location" do
      location = create(:location)
      photo = create(:photo, location: location)
      expect(location.popularity).to eq 0

      location.update_location_popularity
      expect(location.popularity).to eq 30
    end
  end
end
