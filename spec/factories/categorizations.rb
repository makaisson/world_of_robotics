FactoryGirl.define do
  factory :categorization do
    association :category
    association :product
  end
end
