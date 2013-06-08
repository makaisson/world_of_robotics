require "spec_helper"

describe Product do
  describe "Validations" do
    it { should validate_presence_of(:title) }
    it { should have_many(:categories).through(:categorizations) }
    it { should have_many(:line_items) }
  end

  describe "Getting and setting price" do
    before :each do
      @product = FactoryGirl.build(:product)
    end

    context "#price" do
      it "should return the amount_in_cents as a Money object" do
        @product.amount_in_cents = 1234
        @product.price.should == Money.new("1234")
      end
    end

    context "#price=" do
      it "should set the amount_in_cents" do
        @product.price = 56.78
        @product.amount_in_cents.should == 5678
      end
    end
  end

  describe "#destroy" do
    let(:product) { FactoryGirl.build(:product) }
    let(:cart)    { FactoryGirl.build(:cart) }

    context "line items reference the product" do
      before :each do
        line_item         = LineItem.new
        line_item.product = product
        line_item.cart    = cart
        line_item.save
      end

      it "should add an error to the model base" do
        product.destroy
        product.errors[:base].should == ['line items present']
      end

      it "should not delete the product" do
        product.destroy
        product.should be_persisted
      end
    end

    context "no line items reference the product" do
      before :each do
        LineItem.delete_all
      end

      it "should delete the product" do
        product.destroy
        product.should_not be_persisted
      end
    end
  end

  describe 'creating with a category' do
    let(:category) { FactoryGirl.create(:category) }
    let(:product_attributes) {
      FactoryGirl.attributes_for(:product).slice(:title, :description).merge(
        price: 10
      )
    }

    it 'saves the product and associates it with a category' do
      product = Product.create_with_category(
        category.id,
        product_attributes
      )
      product.should be_persisted
      product.categories.should == [category]
    end

    it 'returns an invalid product if failed to save' do
      product = Product.create_with_category(
        category.id,
        {}
      )

      product.should_not be_persisted
      product.errors.should_not be_empty
    end

    it 'returns an unsaved product if category is invalid' do
      product = Product.create_with_category(
        category.id + 1,
        product_attributes
      )
      product.should_not be_persisted
      product.errors.should_not be_empty
    end
  end
end
