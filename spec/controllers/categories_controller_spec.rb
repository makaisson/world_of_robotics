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
end
