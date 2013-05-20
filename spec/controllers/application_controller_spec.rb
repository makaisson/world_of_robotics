require "spec_helper"

describe ApplicationHelper do
  describe "#current_cart" do
    let(:session) { double }

    context "when no cart exists in the session" do
      it "should create a new cart and store it in the session"
    end

    context "when a cart exists in the session" do
      it "should return the existing cart"
    end
  end
end
