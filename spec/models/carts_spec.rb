require "spec_helper"

describe Cart do
  describe "Validations" do
    it { should have_many(:line_items).dependent(:destroy) }
  end
end
