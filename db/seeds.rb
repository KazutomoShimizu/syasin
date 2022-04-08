100.times do |n|
  name = Faker::Games::SuperMario.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end
