require 'spec_helper'

describe ProductsController do
  describe "#index" do
    before { get(:index) }

    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  describe "#show" do
    before do
      product = FactoryGirl.create(:product)
      get(:show, id: product.id)
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end

  describe "#new" do
    before { get(:new) }

    it { should render_template(:new) }
  end

  describe "#create" do
    let(:product) { double(:product, id: 1) }

    before do
      CreateProductWithCategoryService
        .should_receive(:new)
        .with({ 'title' => 'Awesome Robot' },'123')
        .and_return(product)

      post :create, {
        product:  {title: 'Awesome Robot'},
        category: {id: 123}
      }
    end

    context "successfully" do
      let(:product) { double('Product', persisted?: true) }

      it { should redirect_to(admin_index_path) }
    end

    context "unsuccessfully" do
      let(:product) { double('Product', persisted?: false) }

      it { should render_template(:new) }
    end
  end
end
