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

end
