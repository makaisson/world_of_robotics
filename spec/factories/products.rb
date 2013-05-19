FactoryGirl.define do
  factory :product do
    title { Faker::Name.name }
    description { Faker::Lorem.paragraph(3) }
    amount_in_cents { rand(1000..10000) }
  end
end
