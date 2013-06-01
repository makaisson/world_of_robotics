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
    let(:product)        { double(:product, id: 1) }
    let(:categorization) { double(:categorization) }

    before do
      Product.stub(:find) { product }
    end

    context "successfully" do
      pending "Can't stub out the join table, params is nil and breaks shit"
      #before do
      #  Categorization.stub(:create) { categorization }
      #  product.should_receive(:save) { true }
      #  post :create
      #end

      #it { should redirect_to(admin_index_path) }
    end

    context "unsuccessfully" do
      before do
        product.should_receive(:save) { false }
        post :create
      end

      it { should render_template(:new) }
    end
  end
end
