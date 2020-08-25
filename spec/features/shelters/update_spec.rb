# User Story 5, Shelter Update
#
# As a visitor
# When I visit a shelter show page
# Then I see a link to update the shelter "Update Shelter"
# When I click the link "Update Shelter"
# Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including:
# - name
# - address
# - city
# - state
# - zip
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/shelters/:id',
# the shelter's info is updated,
# and I am redirected to the Shelter's Show page where I see the shelter's updated info
require 'rails_helper'

describe 'As a user', type: :feature do
  it 'I can update a shelter' do
    shelter = Shelter.create!(name: 'First Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)

    visit "/shelters/#{shelter.id}"

    click_on 'Update Shelter'

    expect(current_path).to eq("/shelters/#{shelter.id}/edit")

    new_name = 'NEW First Shelter'
    new_address = 'NEW 1st St.'
    new_city = 'NEW Bakersfield'
    new_state = 'NEW CA'
    new_zip = 99993303

    fill_in 'Name', with: new_name
    fill_in 'Address', with: new_address
    fill_in 'City', with: new_city
    fill_in 'State', with: new_state
    fill_in 'Zip', with: new_zip

    click_on 'Update Shelter'

    

    expect(page).to have_content(new_name)
    expect(page).to have_content(new_address)
    expect(page).to have_content(new_city)
    expect(page).to have_content(new_state)
    expect(page).to have_content(new_zip)
  end
end
