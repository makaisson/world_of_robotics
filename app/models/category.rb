class Category < ActiveRecord::Base
  attr_accessible :title, :description
  validates       :title, presence: true
end
