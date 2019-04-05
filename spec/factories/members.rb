FactoryBot.define do
  factory :member do
    name              { Faker::Name.name }
    original_website  { Faker::Internet.url }
  end
end
