require 'rails_helper'

describe 'the new page' do
  it 'has a form to create a new pet' do
    shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)

    visit "/shelters/#{shelter.id}/pets"

    click_on 'Create Pet'

    expect(current_path).to eq("/shelters/#{shelter.id}/pets/new")

    image = 'img001.png'
    name = 'Harley'
    age = 3
    description = 'The friendliest girl out there'
    sex = 'Female'

    fill_in :image, with: image
    fill_in :name, with: name
    fill_in :age, with: age
    fill_in :description, with: description
    fill_in :sex, with: sex

    click_on 'Create Pet'

    expect(current_path).to eq("/shelters/#{shelter.id}/pets")

    

    # expect(page).to have_content(image)
    expect(page).to have_content(name)
    expect(page).to have_content(age)
    expect(page).to have_content(sex)
  end
end
