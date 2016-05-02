require 'rails_helper'
require 'support/omniauth.rb'

feature "list of locations" do
  background do
    set_omniauth
  end

  scenario 'successfully views list after search' do
    visit root_path

    find("#log_in").click
    fill_in 'search', with: "33 Harrison Ave, Boston, MA"
    within 'form' do
      find('.icon').click
    end

    expect(page).to have_content("TRENDING")
    expect(page).to have_content("Beard Papa's Boston")
    expect(page).to have_content("China Pearl Restaurant - Boston")
    expect(page).to have_content("Avana Sushi Boston")
  end
end
