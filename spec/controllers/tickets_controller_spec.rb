require 'spec_helper'

describe TicketsController do

  before do
    Project.create()
    3.times do
      FactoryGirl.create(:ticket)
      FactoryGirl.create(:tag)
    end
    Tagging.create(ticket_id: 1, tag_id: 1)
    Tagging.create(ticket_id: 1, tag_id: 2)
    Tagging.create(ticket_id: 3, tag_id: 1)
    Tagging.create(ticket_id: 2, tag_id: 3)

    controller.stub(:basic_auth).and_return(true)

  end

  describe "show" do
    it "returns http success" do
      get 'show', {project_id: 1, id: 1}
      response.should be_success
    end
  end
end