require 'rails_helper'
require 'support/omniauth.rb'

feature "address search" do
  background do
    set_omniauth
  end

  scenario 'successfully searches after log in' do
    visit root_path

    find("#log_in").click
    fill_in 'search', with: "33 Harrison Ave, Boston, MA"
    within 'form' do
      find('.icon').click
    end

    expect(page).to have_content("TRENDING")
  end

  scenario 'successfully searches without log in' do
    visit root_path

    fill_in 'search', with: "33 Harrison Ave, Boston, MA"
    within 'form' do
      find('.icon').click
    end

    expect(page).to have_content("TRENDING")
  end
end
