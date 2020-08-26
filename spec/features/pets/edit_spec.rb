require 'rails_helper'

describe 'Pet edit page' do
  it 'can be accessed through show page and provides form to update pet information' do
    shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    pet = Pet.create!(image: 'img002.png',name: 'Bendita', age: 5, sex: 'Female', shelter: shelter)

    visit "/pets/#{pet.id}"

    click_on 'Update Pet'

    expect(current_path).to eq("/pets/#{pet.id}/edit")

    new_age = 20

    fill_in :age, with: new_age

    click_on 'Update Pet'

    expect(current_path).to eq("/pets/#{pet.id}")
    

    expect(page).to have_content(new_age)
  end
end
