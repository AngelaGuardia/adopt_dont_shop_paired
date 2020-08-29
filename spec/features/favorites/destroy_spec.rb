require 'rails_helper'

describe 'Remove a Favorite' do

  before(:each) do
    @shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    @pet = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: @shelter, description: "I'm a good boy", adoption_status: 'Adoptable')
  end

  it "can't favorite a pet more than once." do

    visit "/pets/#{@pet.id}"

    click_link "Favorite Me!"

    expect(page).to_not have_content("Favorite Me!")

    click_link "Remove me from your favorites"

    expect(current_path).to eq("/pets/#{@pet.id}")
    expect(page).to have_content("You have removed #{@pet.name} from your favorites!")
    expect(page).to have_link("Favorite Me!")
    expect(page).to have_button("My Favorites: 0")
  end
end
