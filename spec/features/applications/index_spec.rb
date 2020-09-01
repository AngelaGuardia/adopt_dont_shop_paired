require 'rails_helper'

describe 'Application Index Page' do
  before(:each) do
    @shelter1 = Shelter.create!(name: '101 Crazy Dalmatians Shelter', address: 'Paw Place', city: 'Orlando', state: 'FL', zip: 88088)
    @bruno = Pet.create!(image: '01.jpg', name: 'Bruno', age: 6, sex: 'Male', shelter: @shelter1, description: "I'm a good strong boy", adoption_status: 'Adoptable')
    @cleo = Pet.create!(image: '02.jpg', name: 'Cleopatra', age: 1, sex: 'Female', shelter: @shelter1, description: "I'm an Egyptian Empress", adoption_status: 'Adoptable')
    @cody = Pet.create!(image: '03.jpg', name: 'Cody', age: 4, sex: 'Male', shelter: @shelter1, description: "I like cuddles", adoption_status: 'Adoptable')
    @dolly = Pet.create!(image: '04.jpg', name: 'Dolly', age: 7, sex: 'Female', shelter: @shelter1, description: "I'm a clone", adoption_status: 'Adoptable')

    @application1 = Application.create!(name: "Elah Pillado", address: "123 SW Gate", city: "Marietta", state: "GA", zip: 30008, phone_number: "7735551224", description: "I'm a very responsible person and I will love them forever!")

    @application1.pets << @bruno
    @application1.pets << @cleo
    @application1.pets << @cody

    @application2 = Application.create!(name: "Mercedes Denuta", address: "123 SW Dr", city: "Sacramento", state: "CA", zip: 90210, phone_number: "7809094348", description: "I'm a very responsible person and I will love them forever and ever!")

    @application2.pets << @bruno
    @application2.pets << @cleo
  end

  it 'can display all applications for a pet' do
    visit "/pets/#{@bruno.id}"

    click_on "All Applications"

    expect(current_path).to eq("/pets/#{@bruno.id}/applications")

    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application2.name)
  end

  it "has links to every applicant's application" do
    visit "/pets/#{@bruno.id}/applications/"
    click_on @application1.name

    expect(current_path).to eq("/applications/#{@application1.id}")

    visit "/pets/#{@bruno.id}/applications/"

    click_on @application2.name
    expect(current_path).to eq("/applications/#{@application2.id}")
  end

  it 'shows no application message when pet has no applications' do
    visit "/pets/#{@dolly.id}/applications/"
    
    expect(page).to have_content("There are no applications for #{@dolly.name} yet!")
  end
end
