FactoryGirl.define do
  factory :category do
    title "category title"
    description "category description"
  end

  factory :category_with_products, parent: :category do
    after(:build) { |category| category.products << create_list(:product, 5) }
  end
end
