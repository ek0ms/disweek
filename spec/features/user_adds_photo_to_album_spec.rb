require 'rails_helper'
require 'support/omniauth.rb'

feature "add photo to album" do
  before(:each) do
    @location = create(:location)
    create(:photo_1, location: @location)
    create(:photo_2, location: @location)
  end

  background do
   set_omniauth()
  end

  scenario 'successfully views photo after adding' do
    visit root_path
    find("#log_in").click

    visit location_path(@location)
    expect(page).to have_content(@location.name)

    click_button('Add', match: :first)
    visit user_photos_path
    expect(page).to have_css("img[src*='cdninstagram']")
  end
end
