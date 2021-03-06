require 'rails_helper'

describe 'Pet show page' do

  before(:each) do
    @shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    @pet = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: @shelter, description: "I'm a good boy", adoption_status: 'Adoptable')
  end

  it "shows a button to favorite a pet. When I click that button, it takes me back to the pet's show page and there's a flash message indicating that the pet has been added to my favorites list. The favorite indicator in the nav bar has incremented by one." do

    visit "/pets/#{@pet.id}"

    click_link "Favorite Me!"

    expect(current_path).to eq("/pets/#{@pet.id}")
    expect(page).to have_content("#{@pet.name} has been added to your favorites!")
    expect(page).to have_button("My Favorites: 1")
  end

end
