FactoryGirl.define do
  factory :product do
    title "product title"
    description "product description"
    amount_in_cents 1000
  end

  factory :product_with_categories, parent: :product do
    after(:build) { |product| product.categories << create_list(:category, 2) }
  end
end
