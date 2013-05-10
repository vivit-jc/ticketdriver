module ProjectsHelper

def basic_auth
  @project = Project.find(params[:id])
  authenticate_or_request_with_http_basic do |user, pass|
    user == @project.manager && pass == @project.passward
  end
end

end
