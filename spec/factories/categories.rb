FactoryGirl.define do
  factory :category do
    title { Faker::Name.name }
    description { Faker::Lorem.paragraph(3) }
  end
end
