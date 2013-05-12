require 'spec_helper'

describe Category do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should have_many(:products).through(:categorizations) }
  end
end
