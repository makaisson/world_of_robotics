require 'spec_helper'

describe Categorization do
  describe "validations" do
    it { should belong_to(:product) }
    it { should belong_to(:category) }
    it { should validate_presence_of(:product_id) }
    it { should validate_presence_of(:category_id) }
  end
end
