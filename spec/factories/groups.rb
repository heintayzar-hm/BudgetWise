FactoryBot.define do
  factory :group do
    name { Faker::Lorem.word }
    icon { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_icon.png'), 'image/png') }
    association :author, factory: :user
  end
end
