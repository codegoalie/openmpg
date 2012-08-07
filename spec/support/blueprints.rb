require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Fillup.blueprint do 
  filled_at { Time.now }
  mileage { 100 }
  gallons { 10 }
  ppg { 3.59 }
end

User.blueprint do
  email { 'test@chrismar035.com' }
  password { 'password' }
end

Vehicle.blueprint do
  user { User.make! }
  nickname { 'VehicleName' }
  year { 2006 }
  make { 'Volkswagen' }
  model { 'Jetta' }
  color { 'Silver' }
end
