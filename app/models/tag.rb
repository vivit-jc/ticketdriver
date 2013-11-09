class Tag < ActiveRecord::Base
  attr_accessible :name, :text
  has_many :taggings
  has_many :tickets, through: :taggings
end
