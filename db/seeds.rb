product   = FactoryGirl.build(:product)
category  = FactoryGirl.build(:category)

categorization = FactoryGirl.create(:categorization)
categorization.product_id = product.id
categorization.category_id = category.id
