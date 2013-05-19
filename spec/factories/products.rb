FactoryGirl.define do
  factory :product do
    title { Faker::Name.name }
    description { Faker::Lorem.paragraph(2) }
    amount_in_cents { rand(1000..10000) }
  end
end
