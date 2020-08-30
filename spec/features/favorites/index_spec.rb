require 'rails_helper'

describe 'Favorite Index Page' do

  before(:each) do
    @shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    @pet = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: @shelter, description: "I'm a good boy", adoption_status: 'Adoptable')
  end

  it "When I have added pets to my favorites list and click on the favorite indicator, it takes me to the favorites index page, I see all pets I've favorited. Each pet in my favorites shows pet name and image." do

    visit "/pets/#{@pet.id}"
    click_link "Favorite Me!"

    click_on "Favorites: 1"

    expect(current_path).to eq("/favorites")
    expect(page).to have_link(@pet.name)
  end

  it 'can show a flash message if there are no favorites' do
    visit "/"
    click_on "Favorites: 0"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Uh-oh! You haven't favorited any pets yet...")
  end

  it "displays a link to adopt a favorited pet" do

    visit "/pets/#{@pet.id}"
    click_link "Favorite Me!"

    visit "/favorites"
    expect(page).to have_button("Adopt a Pet Today!")
  end

  it "displays a list of pets that have an application on them " do
    visit "/pets/#{@pet.id}"
    click_link "Favorite Me!"

    click_on "Favorites: 1"
    expect(current_path).to eq("/favorites")

    click_on "Adopt a Pet Today!"
    expect(current_path).to eq("/applications/new")

    expect(page).to have_content(@pet.name)

    find("#favorite_pet_id_#{@pet.id}").click

    name = "Elah Pillado"
    address = "123 SW Gate"
    city = "Marietta"
    state = "GA"
    zip = 30008
    phone_number = "7735551224"
    description = "I'm a very responsible person and I will love them forever!"
    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip
    fill_in :phone_number, with: phone_number
    fill_in :description, with: description
    click_on 'Submit My Application'

    expect(current_path).to eq("/favorites")

    within(".list-group") do
      expect(page).to have_content("Pets you have applied for adoption:")
      expect(page).to have_link(@pet.name)
    end
    save_and_open_page
  end

end
