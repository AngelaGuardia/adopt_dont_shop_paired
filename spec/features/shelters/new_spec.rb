require 'rails_helper'

describe 'New Shelter', type: :feature do
  describe 'As a visitor' do
    describe 'When I visit the new shelter by clicking a link on the index' do
      it 'I can create a new shelter' do

        visit '/shelters'

        click_link 'New Shelter'

        expect(current_path).to eq('/shelters/new')

        fill_in 'Name', with: 'First Shelter'
        fill_in 'Address', with: '1st St.'
        fill_in 'City', with: 'Bakersfield'
        fill_in 'State', with: 'CA'
        fill_in 'Zip', with: 93303

        click_on 'Create Shelter'

        shelter = Shelter.last

        expect(current_path).to eq('/shelters')
        expect(page).to have_content(shelter.name)
      end
    end
  end
end
