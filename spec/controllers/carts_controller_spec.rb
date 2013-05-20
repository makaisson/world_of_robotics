require "spec_helper"

describe CartsController do
  describe "#show" do
    before do
      cart = Cart.create
      get(:show, id: cart.id)
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end
end
