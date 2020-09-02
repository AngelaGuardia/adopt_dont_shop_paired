require 'rails_helper'

describe 'pet show page' do
  it 'can delete pet' do
    shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
    shelter2 = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)

    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1, adoption_status: 'Adoptable')
    pet2 = Pet.create!(image: 'img002.png',name: 'Kitty', age: 7, sex: 'Female', shelter: shelter2)

    visit "/pets/#{pet1.id}"

    click_on 'Delete Pet'

    expect(current_path).to eq('/pets')

    expect(page).to have_content(pet2.name)
    expect(page).not_to have_content(pet1.name)
  end

  it 'cannot delete pet if it has approved applications' do
    shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)

    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1, adoption_status: 'Adoptable')

    application1 = Application.create!(name: "Elah Pillado", address: "123 SW Gate", city: "Marietta", state: "GA", zip: 30008, phone_number: "7735551224", description: "I'm a very responsible person and I will love them forever!")
    PetApplication.create(application: application1, pet: pet1)

    visit "/pets/#{pet1.id}"

    click_link "Favorite Me!"

    visit "/applications/#{application1.id}"

    within("#pet-#{pet1.id}") do
      expect(page).to have_link("Approve")
      click_on "Approve"
    end

    visit "/pets/#{pet1.id}"

    expect(page).not_to have_content("Delete Pet")
  end
end
