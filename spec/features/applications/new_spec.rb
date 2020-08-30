require 'rails_helper'

describe 'New Pet Adoption Application' do

  before(:each) do
    @shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    @pet1 = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: @shelter, description: "I'm a good boy", adoption_status: 'Adoptable')
    @pet2 = Pet.create!(image: '03.jpg', name: 'Bubba', age: 5, sex: 'Female', shelter: @shelter, description: "I'm the best", adoption_status: 'Adoptable')
  end

  it "displays a form where I can apply one or more pets I've favorited. When I submit, I see a flash message indicating my application went through and I'm redirected to the favorites page where the pets I just applied for are not there." do

    visit "/pets/#{@pet1.id}"
    click_link "Favorite Me!"

    visit "/pets/#{@pet2.id}"
    click_link "Favorite Me!"

    click_on "Favorites: 2"
    expect(current_path).to eq("/favorites")

    click_on "Adopt a Pet Today!"
    expect(current_path).to eq("/applications/new")

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)
    # I wanted to use something like "check 'Lucas' but don't know if that's allowed with Bootstrap"

    name = "Elah Pillado"
    address = "123 SW Gate"
    city = "Marietta"
    state = "GA"
    zip = 30008
    phone_number = 7735551224
    description = "I'm a very responsible person and I will love them forever!"

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip
    fill_in :phone_number, with: phone_number
    fill_in :description, with: description

    click_on 'Submit My Application'

    expect(page).to have_content("Submission complete. You're one step closer to becoming a pet owner!")
    expect(current_path).to eq("/favorites")
  end

  it "cannot submit an application successfully if it's incomplete." do
    visit "/pets/#{@pet1.id}"
    click_link "Favorite Me!"

    visit "/pets/#{@pet2.id}"
    click_link "Favorite Me!"

    click_on "Favorites: 2"
    expect(current_path).to eq("/favorites")

    click_on "Adopt a Pet Today!"
    expect(current_path).to eq("/applications/new")

    expect(page).to have_content(@pet1.name)

    name = "Elah Pillado"

    fill_in :name, with: name
    fill_in :address, with: ""
    fill_in :city, with: ""
    fill_in :state, with: ""
    fill_in :zip, with: ""
    fill_in :phone_number, with: ""
    fill_in :description, with: ""

    click_on 'Submit My Application'

    expect(page).to have_content("Oh no! Please fill out missing fields before hitting the submit button.")
    expect(current_path).to eq("/applications/new")
  end

end
