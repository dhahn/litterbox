# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

lat = 37.205340
lon = -93.289870

15.times do |i|
	user = User.create(
		email: "test#{i}@example.com",
		password: 'password',
		password_confirmation: 'password',
		first_name: "first name #{i}",
		last_name: "last name #{i}",
		age: (18..35),
		primary_phone: "1231231234",
		secondary_phone: "1231231234",
		gender: ['m', 'f'].sample
	)

	litter_box = LitterBox.create(
		user_id: user.id,
		capacity: (1..5),
		description: "test description",
		city: "Springfield",
		state: "MO",
		address_line_1: "Some Place",
		address_line_2: "Some Where",
		zip: "65807",
		number_of_adults: (1..3),
		number_of_children: (0..3),
		number_of_pets: (0..3),
		latitude: lat += 0.1,
		longitude: lon += 0.1
	)
end
