require "spec_helper"

describe ProductsController do
  describe "#index" do
    before { get(:index) }

    it { should respond_with(:success) }
  end
end
