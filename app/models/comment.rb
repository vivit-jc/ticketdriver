class Comment < ActiveRecord::Base
  belongs_to :ticket
  attr_accessible :name, :ticket_id, :comment
end
