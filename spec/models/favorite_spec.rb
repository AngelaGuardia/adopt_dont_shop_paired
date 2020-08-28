require 'rails_helper'

describe 'favorite model' do
  it 'can list all the favorite pets' do
    shelter = Shelter.create!(name: 'Dog Shelter', address: '1st St.', city: 'Bakersfield', state: 'CA', zip: 93303)
    pet1 = Pet.create!(image: 'img001.png', name: 'Olaf', age: 3, sex: 'Male', shelter: shelter)
    pet2 = Pet.create!(image: 'img002.png',name: 'Kitty', age: 7, sex: 'Female', shelter: shelter)

    favorite = Favorite.new([pet1.id, pet2.id])

    expect(favorite.pets).to eq([pet1, pet2])
  end
end
