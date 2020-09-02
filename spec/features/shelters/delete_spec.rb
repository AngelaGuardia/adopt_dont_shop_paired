require 'rails_helper'

describe 'As a user', type: :feature do

  before(:each) do
    @shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    @shelter1 = Shelter.create!(name: 'Puppy Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)

    @pet1 = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: @shelter, description: "I'm a good boy", adoption_status: 'Adoptable')
    @pet2 = Pet.create!(image: '03.jpg', name: 'Bubba', age: 5, sex: 'Female', shelter: @shelter, description: "I'm the best", adoption_status: 'Adoptable')
    @application1 = Application.create!(name: "Elah Pillado", address: "123 SW Gate", city: "Marietta", state: "GA", zip: 30008, phone_number: "7735551224", description: "I'm a very responsible person and I will love them forever!")
    PetApplication.create(application: @application1, pet: @pet1)
    PetApplication.create(application: @application1, pet: @pet2)
  end

  it 'I can delete a shelter' do

    visit "/shelters/#{@shelter1.id}"

    click_on 'Delete Shelter'

    expect(current_path).to eq('/shelters')

    expect(page).not_to have_content(@shelter1.name)
  end

  it "shelters with pets that have pending status cannot be deleted" do

    visit "/pets/#{@pet1.id}"
    click_link "Favorite Me!"

    visit "/applications/#{@application1.id}"

    within("#pet-#{@pet1.id}") do
      expect(page).to have_link("Approve")
      click_on "Approve"
    end

    visit "/shelters/#{@shelter.id}"

    expect(current_path).to eq("/shelters/#{@shelter.id}")
    expect(page).to have_content(@shelter.name)
    expect(page).to_not have_button("Delete Shelter")
  end
end
