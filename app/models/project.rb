class Project < ActiveRecord::Base
  attr_accessible :manager, :name, :passward
  has_many :tickets
  accepts_nested_attributes_for :tickets
end
