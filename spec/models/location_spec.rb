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
    it "creates photo objects for the location" do
      location = create(:location)
      location.create_photos

      photos_uri = URI("https://api.instagram.com/v1/locations/#{location.insta_id}/media/recent?access_token=393459182.5550f72.40571a65e1074b8f95e17a89146768e3")
      response = Net::HTTP.get_response(photos_uri)
      media_from_location = JSON.parse(response.body)["data"]

      expect(location.photos.length).to eq media_from_location.length
    end
  end
end
