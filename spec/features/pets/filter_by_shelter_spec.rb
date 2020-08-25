require 'rails_helper'

describe 'the filter by shelter page' do
  it "shows each pet that can be adopted from the shelter" do
    shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1)
    pet2 = Pet.create!(image: 'img002.png',name: 'Kitty', age: 7, sex: 'Female', shelter: shelter1)

    shelter2 = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    pet3 = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: shelter2)
    pet4 = Pet.create!(image: 'img002.png',name: 'Bendita', age: 5, sex: 'Female', shelter: shelter2)

    visit "/shelters/#{shelter1.id}/pets"


    # expect(page).to have_content(pet1.image)
    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet1.age)
    expect(page).to have_content(pet1.sex)

    # expect(page).to have_content(pet2.image)
    expect(page).to have_content(pet2.name)
    expect(page).to have_content(pet2.age)
    expect(page).to have_content(pet2.sex)
    expect(page).to have_content(pet2.shelter.name)

    expect(page).not_to have_content(pet3.name)
    expect(page).not_to have_content(pet4.name)
  end

  it 'has a link to shelter show page' do
    shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1)
    pet2 = Pet.create!(image: 'img002.png',name: 'Kitty', age: 7, sex: 'Female', shelter: shelter1)

    visit "/shelters/#{shelter1.id}/pets"

    click_on "#{shelter1.name}"

    expect(current_path).to eq("/shelters/#{shelter1.id}")
  end

  it 'has a link to pets show page' do
    shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1)
    pet2 = Pet.create!(image: 'img002.png',name: 'Kitty', age: 7, sex: 'Female', shelter: shelter1)

    visit "/shelters/#{shelter1.id}/pets"

    click_on "#{pet1.name}"

    expect(current_path).to eq("/pets/#{pet1.id}")

    visit "/shelters/#{shelter1.id}/pets"

    click_on "#{pet2.name}"

    expect(current_path).to eq("/pets/#{pet2.id}")
  end
end
