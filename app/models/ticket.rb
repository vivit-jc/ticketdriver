# encoding: utf-8

class Ticket < ActiveRecord::Base
  attr_accessible :finished, :memo, :name, :person, :priority, :status, :project_id, :updated_at
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :project
  accepts_nested_attributes_for :project

  def get_status
    return Ticket::get_status_no(self.status)
  end

  def get_priority
    return Ticket::get_priority_no(self.priority)
  end

  def update_j
    time = self.updated_at
    return time.year.to_s + "年" + time.month.to_s + "月" + time.day.to_s + "日 " + time.hour.to_s + ":" + ("%02d" % time.min ).to_s
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

  def recent_comment_color
    [["red",2*24*60*60],["green",7*24*60*60],["blue",31*24*60*60]].each do |set|
      return set[0] if(recent_comment?(set[1]))
    end
    return "black"
  end


  def recent_ticket_color
    return "red" if(self.updated_at > Time.now - 2*24*60*60)
    return "green" if(self.updated_at > Time.now - 7*24*60*60)
    return "blue" if(self.updated_at > Time.now - 31*24*60*60)
    return "black"
  end

  def recent_comment?(time)
    return self.comments.select{|c| c.updated_at > Time.now - time}.count > 0
  end

  def oarray
    return [self.name,self.status,self.person,self.priority,self.finished,self.memo,self.project_id,self.created_at]
  end

  def iarray(array)
    self.name = array[0]
    self.status = array[1]
    self.person = array[2]
    self.priority = array[3]
    self.finished = array[4]
    self.memo = array[5]
    self.project_id = array[6]
    self.created_at = array[7]
    self.save
  end

end
