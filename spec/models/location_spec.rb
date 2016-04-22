require 'rails_helper'

describe Location do
  describe "#address" do
    it "prints out full address" do
      location = create(:location)
      expect(location.address).to eq "27 Harrison Ave, Boston, MA"
    end
  end
end
