require "spec_helper"

describe LineItem do
  describe "Validations" do
    it { should belong_to(:product) }
    it { should belong_to(:cart) }
  end
end
