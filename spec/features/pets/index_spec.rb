require 'rails_helper'

describe 'pets index page', type: :feature do
  it 'can show the img, name, age, sex, and shelter for each pet' do
    shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
    shelter2 = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)

    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1)
    pet2 = Pet.create!(image: 'img002.png',name: 'Kitty', age: 7, sex: 'Female', shelter: shelter2)

    visit '/pets'

    

    # expect(page).to have_content(pet1.image)
    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet1.age)
    expect(page).to have_content(pet1.sex)
    expect(page).to have_content(pet1.shelter.name)
    #
    # expect(page).to have_content(pet2.image)
    expect(page).to have_content(pet2.name)
    expect(page).to have_content(pet2.age)
    expect(page).to have_content(pet2.sex)
    expect(page).to have_content(pet2.shelter.name)
  end

  it 'can edit pets from the index page' do
    shelter1 = Shelter.create!(name: 'First Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)

    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1)

    visit "/pets"

    click_on "Update"

    expect(current_path).to eq("/pets/#{pet1.id}/edit")
  end

  it 'can edit pets from the index page' do
    shelter1 = Shelter.create!(name: 'First Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)

    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1)

    visit "/pets"

    click_on "Delete"

    expect(page).not_to have_content("#{pet1.name}")
  end

  it 'has a link to shelter show page' do
    shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1)

    visit "pets"

    click_on "#{shelter1.name}"

    expect(current_path).to eq("/shelters/#{shelter1.id}")
  end

  it 'has a link to pets show page' do
    shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter1)
    pet2 = Pet.create!(image: 'img002.png',name: 'Kitty', age: 7, sex: 'Female', shelter: shelter1)

    visit "/pets"

    click_on "#{pet1.name}"

    expect(current_path).to eq("/pets/#{pet1.id}")

    visit "/pets"

    click_on "#{pet2.name}"

    expect(current_path).to eq("/pets/#{pet2.id}")
  end
end
