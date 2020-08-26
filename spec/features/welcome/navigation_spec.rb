require 'rails_helper'

describe 'Navigation Bar' do
  it 'has workable buttons' do
    visit "/"

    click_link "Shelters"
    expect(current_path).to eq("/shelters")

    click_link "Pets"
    expect(current_path).to eq("/pets")
  end

  it "has a favorite indicator" do

    visit "/"

    expect(page).to have_content("My Favorites: 0")
  end
end
