require 'rails_helper'

describe 'Navigation Bar' do

  it 'has workable buttons' do
    visit "/"

    click_button "Shelters"
    expect(current_path).to eq("/shelters")

    click_button "Pets"
    expect(current_path).to eq("/pets")
  end

  it "has a favorite indicator" do
    visit "/"

    expect(page).to have_button("My Favorites: 0")
  end
end
