require 'rails_helper'

describe 'Remove a Favorite' do

  before(:each) do
    @shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    @pet = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: @shelter, description: "I'm a good boy", adoption_status: 'Adoptable')
  end

  it "can't favorite a pet more than once." do

    visit "/pets/#{@pet.id}"

    click_link "Favorite Me!"

    expect(page).to_not have_content("Favorite Me!")

    click_link "Remove me from your favorites"

    expect(current_path).to eq("/pets/#{@pet.id}")
    expect(page).to have_content("You have removed #{@pet.name} from your favorites!")
    expect(page).to have_content("My Favorites: 0")
    expect(page).to have_link("Favorite Me!")
  end
end

# User Story 12, Can't Favorite a Pet More Than Once
#
# As a visitor
# After I've favorited a pet
# When I visit that pet's show page
# I no longer see a link to favorite that pet
# But I see a link to remove that pet from my favorites
# When I click that link
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to that pets show page where I can see a flash message indicating that the pet was removed from my favorites
# And I can now see a link to favorite that pet
# And I also see that my favorites indicator has decremented by 1
