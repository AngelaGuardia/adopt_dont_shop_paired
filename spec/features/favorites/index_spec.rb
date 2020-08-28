require 'rails_helper'

describe 'Favorite Index Page' do

  before(:each) do
    @shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    @pet = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: @shelter, description: "I'm a good boy", adoption_status: 'Adoptable')
  end

  it "When I have added pets to my favorites list and click on the favorite indicator, it takes me to the favorites index page, I see all pets I've favorited. Each pet in my favorites shows pet name and image." do

    visit "/pets/#{@pet.id}"
    click_link "Favorite Me!"

    click_link "Favorites: 1"

    expect(current_path).to eq("/favorites")
    expect(page).to have_link(@pet.name)
    # expect(page).to have_content(@pet.image)
  end

end