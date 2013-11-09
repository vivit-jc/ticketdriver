class Tagging < ActiveRecord::Base
  attr_accessible :ticket_id, :tag_id
  belongs_to :ticket
  belongs_to :tag
end
