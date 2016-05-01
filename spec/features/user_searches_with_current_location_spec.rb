require 'rails_helper'
require 'support/omniauth.rb'

feature "current location search" do
  background do
   set_omniauth()
  end

  scenario 'successfully views list after search' do
    visit root_path

    find("#log_in").click
    fill_in 'search', with: "Current Location"
    within 'form' do
      find('.icon').click
    end

    expect(page).to have_content("TRENDING")
    expect(page).to have_content("Woodland Park Zoo")
    expect(page).to have_content("Green Lake Park")
  end
end
