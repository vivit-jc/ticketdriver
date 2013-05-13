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

  def basic_auth
    @project = Project.find(params[:project_id])
    authenticate_or_request_with_http_basic do |user, pass|
      user == @project.manager && pass == @project.passward
    end
  end

  def exchange(t1,t2)
    t1.comments.each do |c|
      c.ticket_id = t2.id
    end
    t2.comments.each do |c|
      c.ticket_id = t1.id
    end
    t1.comments.each {|c| c.save}
    t2.comments.each {|c| c.save}
    
    temparray = t1.oarray
    t1.iarray(t2.oarray)
    t2.iarray(temparray)
  end

end
