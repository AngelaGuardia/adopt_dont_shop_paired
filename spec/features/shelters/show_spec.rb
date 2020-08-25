require 'rails_helper'

describe 'shelters show page shows shelter with that id', type: :feature do
    it 'including the name, address, city, state, and zip' do
        shelter1 = Shelter.create!(name: 'First Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)

        visit "/shelters/#{shelter1.id}"
        

        expect(page).to have_content(shelter1.name)
        expect(page).to have_content(shelter1.address)
        expect(page).to have_content(shelter1.city)
        expect(page).to have_content(shelter1.state)
        expect(page).to have_content(shelter1.zip)
    end

    it 'has a link to see all pets in that shelter' do
      shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
      pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1)
      pet2 = Pet.create!(image: 'img002.png',name: 'Kitty', age: 7, sex: 'Female', shelter: shelter1)

      visit "/shelters/#{shelter1.id}"

      click_on "All Our Pets"

      expect(current_path).to eq("/shelters/#{shelter1.id}/pets")
    end
end
