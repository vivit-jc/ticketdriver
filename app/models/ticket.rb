# encoding: utf-8

class Ticket < ActiveRecord::Base
  attr_accessible :finished, :memo, :name, :person, :priority, :status, :project_id
  has_many :comments
  belongs_to :project
  accepts_nested_attributes_for :project

  def get_status
    return Ticket::get_status_no(self.status)
  end

  def get_priority
    return Ticket::get_priority_no(self.priority)
  end

  def self.get_status_no(status)
    case(status)
    when 0
      return "開発"
    when 1
      return "バグ報告"
    end
  end

  def self.get_priority_no(priority)
    case(priority)
    when 0
      return "★★★★★"
    when 1
      return "★★★★"
    when 2
      return "★★★"
    when 3
      return "★★"
    when 4
      return "★"
    end
  end

end
