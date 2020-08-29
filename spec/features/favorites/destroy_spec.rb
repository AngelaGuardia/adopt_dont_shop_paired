require 'rails_helper'

describe 'Remove a Favorite' do

  before(:each) do
    @shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    @pet1 = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: @shelter, description: "I'm a good boy", adoption_status: 'Adoptable')
    @pet2 = Pet.create!(image: '03.jpg', name: 'Bubba', age: 5, sex: 'Female', shelter: @shelter, description: "I'm the best", adoption_status: 'Adoptable')
  end

  it "can't favorite a pet more than once." do

    visit "/pets/#{@pet1.id}"
    click_link "Favorite Me!"

    expect(page).to_not have_content("Favorite Me!")

    click_link "Remove me from your favorites"

    expect(current_path).to eq("/pets/#{@pet1.id}")

    expect(page).to have_content("You have removed #{@pet1.name} from your favorites!")
    expect(page).to have_link("Favorite Me!")
    expect(page).to have_button("My Favorites: 0")
  end

  it 'removed pet from favorites page' do
    visit "/pets/#{@pet1.id}"
    click_link "Favorite Me!"

    visit "/pets/#{@pet2.id}"
    click_link "Favorite Me!"

    visit '/favorites'

    within("#pet-#{@pet1.id}") do
      click_on "Remove me from your favorites"
    end

    expect(current_path).to eq('/favorites')

    expect(page).not_to have_css("#pet-#{@pet1.id}")
  end
end
