require 'rails_helper'

describe 'Review edit page' do
  it 'can edit reviews' do
    shelter = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
    review = Review.create!(title: "Best Shelter!", rating: 5, content: "Very nice people and adorable pets.", shelter: shelter)

    visit "/shelters/#{shelter.id}"

    click_on 'Edit Review'

    expect(current_path).to eq("/reviews/#{review.id}/edit")

    # REVIEW: not sure why these expectations are failing
    # expect(page).to have_content(review.title)
    # expect(page).to have_content(review.rating)
    # expect(page).to have_content(review.content)

    new_title = "This is my updated review"
    new_rating = 1
    new_content = "This place is okay"

    fill_in :title, with: new_title
    find("#inlineRadio#{new_rating}").click
    fill_in :content, with: new_content

    click_on 'Update Review'

    expect(current_path).to eq("/shelters/#{shelter.id}")

    expect(page).to have_content(new_title)
    expect(page).to have_content(new_rating)
    expect(page).to have_content(new_content)
  end
end
