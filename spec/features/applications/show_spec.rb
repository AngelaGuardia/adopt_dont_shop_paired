require 'rails_helper'

describe 'Application Show Page' do

  before(:each) do
    @shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    @pet1 = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: @shelter, description: "I'm a good boy", adoption_status: 'Adoptable')
    @pet2 = Pet.create!(image: '03.jpg', name: 'Bubba', age: 5, sex: 'Female', shelter: @shelter, description: "I'm the best", adoption_status: 'Adoptable')
    @application = Application.create!(name: "Elah Pillado", address: "123 SW Gate", city: "Marietta", state: "GA", zip: 30008, phone_number: "7735551224", description: "I'm a very responsible person and I will love them forever!")
    PetApplication.create(application: @application, pet: @pet1)
    PetApplication.create(application: @application, pet: @pet2)
  end

  it "displays the application form and the names of the pets it pertains to." do

    visit "/pets/#{@pet1.id}"
    click_link "Favorite Me!"

    visit "/pets/#{@pet2.id}"
    click_link "Favorite Me!"

    visit "/applications/#{@application.id}"

    expect(page).to have_content("Adoption application for the following pets:")
    expect(page).to have_link(@pet1.name)
    expect(page).to have_link(@pet2.name)

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip)
    expect(page).to have_content(@application.phone_number)
    expect(page).to have_content(@application.description)
  end

end
