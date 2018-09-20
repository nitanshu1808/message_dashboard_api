# Creating users using faker gem
100.times do
  User.create({
    email:        FFaker::Internet.free_email,
    first_name:   FFaker::Name.first_name,
    last_name:    FFaker::Name.last_name,
    amount:       FFaker::AddressFI.building_number.to_f
  })
end
