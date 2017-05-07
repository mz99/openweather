require 'spec_helper'
require 'rails_helper'

RSpec.feature "user selects city & country" do
  scenario "allow a user to select city & country" do
    visit root_path

    page.select( 'Germany', from: 'country')
    fill_in('city', with: 'Berlin')
    click_button("Search")

    expect(page).to have_content("Germany")
  end
end
