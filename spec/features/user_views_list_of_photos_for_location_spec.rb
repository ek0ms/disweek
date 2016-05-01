require 'rails_helper'
require 'support/omniauth.rb'

feature "list of photos for location" do
  before(:each) do
    @location = create(:location)
    create(:photo_1, location: @location)
    create(:photo_2, location: @location)
  end

  background do
   set_omniauth()
  end

  scenario 'successfully views list after search' do
    visit location_path(@location)

    expect(page).to have_content(@location.name)
    expect(page).to have_css("img[src*='cdninstagram']")
    expect(page).to have_content("poofs")
    expect(page).to have_content("i love cream puffs")
  end
end
