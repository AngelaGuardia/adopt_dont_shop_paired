require 'rails_helper'

describe 'review new page' do
  before(:each) do
    @shelter = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
  end

  it 'can create a new review' do
    visit "/shelters/#{@shelter.id}"

    click_on "Add a Review"

    expect(current_path).to eq("/shelters/#{@shelter.id}/reviews/new")

    title = "Awesome experience!"
    rating = 5
    content = "Loved my time at this shelter! Great staff and cute animals."
    picture = "https://www.google.com/imgres?imgurl=https%3A%2F%2Femojipedia-us.s3.dualstack.us-west-1.amazonaws.com%2Fsocialmedia%2Fapple%2F237%2Fthumbs-up-sign_1f44d.png&imgrefurl=https%3A%2F%2Femojipedia.org%2Fthumbs-up%2F&tbnid=lco7dN6r1KKltM&vet=12ahUKEwjZ89zAuLfrAhXERawKHXmoA5cQMygAegUIARDUAQ..i&docid=ed1d6h8WtvmM2M&w=560&h=300&q=thumbs%20up&ved=2ahUKEwjZ89zAuLfrAhXERawKHXmoA5cQMygAegUIARDUAQ"

    fill_in :title, with: title
    find('#inlineRadio5').click
    fill_in :content, with: content
    fill_in :picture, with: picture

    click_on 'Post Review'

    expect(current_path).to eq("/shelters/#{@shelter.id}")

    expect(page).to have_content(title)
    expect(page).to have_content(rating)
    expect(page).to have_content(content)
    expect(page.find('img')['src']).to have_content(picture)
  end
end
