catalogue = {
  "humanoids" => ["NAO", "Ed-E", "Asimo"],
  "sporting robots" => ["soccer robot", "mindstorms soccer kit"],
  "modular construction" => ["Lego", "Lego Mindstorms", "Robotix Starter Kit", "Capsela"]
}

catalogue.each do |category_title, products|
  category = FactoryGirl.create(:category, title: category_title)

  products.each do |product_title|
    product = FactoryGirl.create(:product, title: product_title)
    FactoryGirl.create(:categorization, product: product, category: category)
  end
end
