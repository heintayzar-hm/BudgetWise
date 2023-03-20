FactoryBot.define do
  factory :group do
    name { Faker::Lorem.word }
    icon { Faker::Photo.image }
    user
  end
end
