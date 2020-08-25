require 'rails_helper'

describe 'shelters show page shows shelter with that id', type: :feature do
  before(:each) do
    @shelter1 = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
  end

  it 'including the name, address, city, state, and zip' do
      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content(@shelter1.name)
      expect(page).to have_content(@shelter1.address)
      expect(page).to have_content(@shelter1.city)
      expect(page).to have_content(@shelter1.state)
      expect(page).to have_content(@shelter1.zip)
  end

  it 'has a link to see all pets in that shelter' do
    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: @shelter1)
    pet2 = Pet.create!(image: 'img002.png',name: 'Kitty', age: 7, sex: 'Female', shelter: @shelter1)

    visit "/shelters/#{@shelter1.id}"

    click_on "All Our Pets"

    expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
  end

  it "it displays all the reviews" do
    review1 = Review.create!(title: "Best Shelter!", rating: 5, content: "Very nice people and adorable pets.", shelter: @shelter1)
    review2 = Review.create!(title: "Best Shelter!", rating: 5, content: "Very nice people and adorable pets.", picture:"https://storage.googleapis.com/wordpress-www-vendasta/Top-14-Review-Sites-fb.jpg", shelter: @shelter1)

    visit "/shelters/#{@shelter1.id}"
    save_and_open_page

    expect(page).to have_content(review1.title)
    expect(page).to have_content(review1.rating)
    expect(page).to have_content(review1.content)

    expect(page).to have_content(review2.title)
    expect(page).to have_content(review2.rating)
    expect(page).to have_content(review2.content)
    expect(page.find('img')['src']).to have_content(review2.picture)
  end
end
