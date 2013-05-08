# encoding: utf-8

class Ticket < ActiveRecord::Base
  attr_accessible :finished, :memo, :name, :person, :priority, :status
  has_many :comments

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
      return "最優先事項よ！"
    when 1
      return "とても高い"
    when 2
      return "高"
    when 3
      return "中"
    when 4
      return "低"
    end
  end

end
