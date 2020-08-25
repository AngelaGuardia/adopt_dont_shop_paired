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

    it "it displays all the reviews" do
      shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
      review1 = Review.create!(title: "Best Shelter!", rating: 5, content: "Very nice people and adorable pets.", picture:"", shelter: shelter1)
      review2 = Review.create!(title: "Best Shelter!", rating: 5, content: "Very nice people and adorable pets.", picture:"https://storage.googleapis.com/wordpress-www-vendasta/Top-14-Review-Sites-fb.jpg", shelter: shelter1)

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content(review1.title)
      expect(page).to have_content(review1.rating)
      expect(page).to have_content(review1.content)
      expect(page).to_not have_content(review1.picture)

      expect(page).to have_content(review2.title)
      expect(page).to have_content(review2.rating)
      expect(page).to have_content(review2.content)
      expect(page).to have_content(review2.picture)
    end

end
# As a visitor,
# When I visit a shelter's show page,
# I see a list of reviews for that shelter
# Each review will have:
# - title
# - rating
# - content
# - an optional picture
