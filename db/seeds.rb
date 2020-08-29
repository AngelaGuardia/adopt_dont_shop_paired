# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter1 = Shelter.create!(name: '101 Crazy Dalmatians Shelter', address: 'Paw Place', city: 'Orlando', state: 'FL', zip: 88088)
bruno = Pet.create!(image: '01.jpg', name: 'Bruno', age: 6, sex: 'Male', shelter: shelter1, description: "I'm a good strong boy", adoption_status: 'Adoptable')
cleo = Pet.create!(image: '02.jpg', name: 'Cleopatra', age: 1, sex: 'Female', shelter: shelter1, description: "I'm an Egyptian Empress", adoption_status: 'Adoptable')
cody = Pet.create!(image: '03.jpg', name: 'Cody', age: 4, sex: 'Male', shelter: shelter1, description: "I like cuddles", adoption_status: 'Adoptable')

shelter2 = Shelter.create!(name: 'Wildcard Shelter', address: 'Wilderness St. SW', city: 'Amazon', state: 'CA', zip: 87686)
dolly = Pet.create!(image: '04.jpg', name: 'Dolly', age: 7, sex: 'Female', shelter: shelter2, description: "I'm a clone", adoption_status: 'Adoptable')
churu = Pet.create!(image: '05.jpg', name: 'Churu Meru', age: 3, sex: 'Male', shelter: shelter2, description: "I'm a great listener", adoption_status: 'Adoptable')
sal = Pet.create!(image: '06.jpg', name: 'Salazar', age: 4, sex: 'Male', shelter: shelter2, description: "I'm very sssspecial'", adoption_status: 'Adoptable')

shelter3 = Shelter.create!(name: 'Tiny Friends Shelter', address: '467 Good St', city: 'Guayana', state: 'MN', zip:68393)
pc = Pet.create!(image: '07.jpg', name: 'Pinky & Cerebro', age: 6, sex: 'Male', shelter: shelter3, description: "We're gonna take over the world", adoption_status: 'Adoptable')
clari = Pet.create!(image: '08.jpg', name: 'Clari', age: 1, sex: 'Female', shelter: shelter3, description: "I'm a good girl", adoption_status: 'Adoptable')
bugs = Pet.create!(image: '09.jpg', name: 'Bugs', age: 6, sex: 'Male', shelter: shelter3, description: "I'm funny ans fast!'", adoption_status: 'Adoptable')
