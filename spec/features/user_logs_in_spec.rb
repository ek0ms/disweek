require 'rails_helper'
require 'support/omniauth.rb'

feature "log in" do
  background do
   set_omniauth()
  end

  scenario 'successfully logs in with Instagram credentials' do
    visit root_path

    find("#log_in").click

    expect(page).to have_content("Usar")
    expect(page).to have_content("Album")
  end
end
