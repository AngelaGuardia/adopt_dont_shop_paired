require 'rails_helper'

describe 'Application Show Page' do

  before(:each) do
    @shelter = Shelter.create!(name: 'Cat Shelter', address: '2nd St.', city: 'Los Angeles', state: 'CA', zip: 93303)
    @pet1 = Pet.create!(image: 'img001.png', name: 'Lukas', age: 10, sex: 'Male', shelter: @shelter, description: "I'm a good boy", adoption_status: 'Adoptable')
    @pet2 = Pet.create!(image: '03.jpg', name: 'Bubba', age: 5, sex: 'Female', shelter: @shelter, description: "I'm the best", adoption_status: 'Adoptable')
    @pet3 = Pet.create!(image: '08.jpg', name: 'Clari', age: 1, sex: 'Female', shelter: @shelter, description: "I'm a good girl", adoption_status: 'Adoptable')
    @application1 = Application.create!(name: "Elah Pillado", address: "123 SW Gate", city: "Marietta", state: "GA", zip: 30008, phone_number: "7735551224", description: "I'm a very responsible person and I will love them forever!")
    @application2 = Application.create!(name: "Sinai Pillado", address: "123 SW Gate", city: "Marietta", state: "GA", zip: 30008, phone_number: "7735558503", description: "We will have so much fun in my big backyard!")

    PetApplication.create(application: @application1, pet: @pet1)
    PetApplication.create(application: @application1, pet: @pet2)

    PetApplication.create(application: @application2, pet: @pet2)
    PetApplication.create(application: @application2, pet: @pet3)
  end

  it "displays the application form and the names of the pets it pertains to." do

    visit "/pets/#{@pet1.id}"
    click_link "Favorite Me!"

    visit "/pets/#{@pet2.id}"
    click_link "Favorite Me!"

    visit "/applications/#{@application1.id}"

    expect(page).to have_content("Adoption application for the following pets:")
    expect(page).to have_link(@pet1.name)
    expect(page).to have_link(@pet2.name)

    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.address)
    expect(page).to have_content(@application1.city)
    expect(page).to have_content(@application1.state)
    expect(page).to have_content(@application1.zip)
    expect(page).to have_content(@application1.phone_number)
    expect(page).to have_content(@application1.description)
  end

  it 'displays approval/pending application information and users can get approved to adopt more than one pet.' do
    visit "/pets/#{@pet1.id}"
    click_link "Favorite Me!"

    visit "/pets/#{@pet2.id}"
    click_link "Favorite Me!"

    visit "/applications/#{@application1.id}"

    within("#pet-#{@pet1.id}") do
      expect(page).to have_link("Approve")
      click_on "Approve"
    end
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Pending - on hold for: #{@application1.name}")

    visit "/applications/#{@application1.id}"

    within("#pet-#{@pet2.id}") do
      expect(page).to have_link("Approve")
      click_on "Approve"
    end
    expect(current_path).to eq("/pets/#{@pet2.id}")
    expect(page).to have_content("Pending - on hold for: #{@application1.name}")
  end

  it "Pets can only have one approved application on them at any time. ALl other applications still remain on file (they can be seen on the pets application index page)" do

    visit "/pets/#{@pet2.id}"
    click_link "Favorite Me!"

    visit "/pets/#{@pet3.id}"
    click_link "Favorite Me!"

    visit "/applications/#{@application1.id}"

    within("#pet-#{@pet2.id}") do
      expect(page).to have_link("Approve")
      click_on "Approve"
    end

    visit "/applications/#{@application2.id}"

    within("#pet-#{@pet2.id}") do
      expect(page).to have_content("Oh no! No more applications can be approved for this pet at this time. We're sorry for the inconvenience!")
    end
    within("#pet-#{@pet3.id}") do
      expect(page).to have_link("Approve")
    end
  end

  it "approved applications can be revoked" do
    visit "/pets/#{@pet1.id}"
    click_link "Favorite Me!"

    visit "/applications/#{@application1.id}"

    within("#pet-#{@pet1.id}") do
      expect(page).to have_link("Approve")
      click_on "Approve"
    end

    visit "/applications/#{@application1.id}"

    within("#pet-#{@pet1.id}") do
      expect(page).to have_link("Unapprove")
    end

    expect(current_path).to eq("/applications/#{@application1.id}")
    within("#pet-#{@pet1.id}") do
      expect(page).to have_link("Approve")
    end

    visit "/pets/#{@pet1.id}"
    expect(page).to have_content("Adoptable")
  end

end
