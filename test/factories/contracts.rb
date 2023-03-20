FactoryBot.define do
  factory :contract do
    name { Faker::Lorem.word }
    amount { Faker::Number.decimal(l_digits: 2) }
    user
  end
end
