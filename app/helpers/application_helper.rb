module ApplicationHelper

  def basic_auth(project_id)
    @project = Project.find(project_id)
    authenticate_or_request_with_http_basic do |user, pass|
      user == @project.manager && pass == @project.passward
    end
  end

end
