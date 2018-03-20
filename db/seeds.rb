# Create some users These shouldn't change after initial deploy

if User.count == 0
  admin = User.create!(
      email:  "edmontononslaught@gmail.com",
      name: "Ward Kapach",
      password_digest: "$2a$10$OTvrczPu1h5zpo8.b61peOm6hHNyvu9aji3R1rKCVoR/JhCpPwXee", #password
      activated: true,
      activated_at: Time.zone.now
  )

  admin = User.create!(
      email:  "stephen.r.lind@gmail.com",
      name: "Stephen Lind",
      password_digest: "$2a$10$OTvrczPu1h5zpo8.b61peOm6hHNyvu9aji3R1rKCVoR/JhCpPwXee", #password
      activated: true,
      activated_at: Time.zone.now
  )
end

if Info.count == 0
  info = Info.create!(
      body: "Welcome to Onslaught!"
  )
end
# Create a bunch of test accounts

# 99.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name:  name,
#                email: email,
#                password:              password,
#                password_confirmation: password,
#                activated: true,
#                activated_at: Time.zone.now)
# end
#
# users = User.order(:created_at).take(6)
