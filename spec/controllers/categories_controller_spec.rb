require 'spec_helper'

describe CategoriesController do
  describe "#index" do
    before { get(:index) }

    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  describe "#show" do
    before do
      category = FactoryGirl.create(:category)
      get(:show, id: category.id)
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end

  describe "#new" do
    before { get(:new) }

    it { should render_template(:new) }
  end

  describe "#create" do
    let(:category) { double(:category, id: 1) }
    before do
      Category.stub(:find) { category }
    end
    context "successfully" do
      before do
        category.should_receive(:save) { true }
        post :create, id: category.id
      end

      it { should redirect_to(admin_index_path) }
    end

    context "unsuccessfully" do
      before do
        category.should_receive(:save) { false }
        post :create
      end

      it { should render_template(:new) }
    end
  end
end
