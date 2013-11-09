module TicketsHelper

  def make_select
    @status_array = []
    2.times do |i|
      @status_array.push([Ticket::get_status_no(i),i])
    end

    @priority_array = []
    5.times do |i|
      @priority_array.push([Ticket::get_priority_no(i),i])
    end
  end

end
