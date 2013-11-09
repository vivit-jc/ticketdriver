# encoding: utf-8

require 'spec_helper'

describe TagsController do

  before do
    3.times do
      FactoryGirl.create(:ticket)
      FactoryGirl.create(:tag)
    end
    Tagging.create(ticket_id: 1, tag_id: 1)
    Tagging.create(ticket_id: 1, tag_id: 2)
    Tagging.create(ticket_id: 3, tag_id: 1)
    Tagging.create(ticket_id: 2, tag_id: 3)

    request.env["HTTP_REFERER"] = "back"
    controller.stub(:basic_auth).and_return(true)

  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    it "タグ一覧の取得" do
      get 'index'
      expect(assigns[:tags].size).to eq(3)
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', {id: 1, project_id: 1}
      response.should be_success
    end
    it "そのタグが付けられているチケットを取得" do
      get 'show', {id: 1}
      expect(assigns[:tickets].size).to eq(2)
    end
  end

  describe "POST 'create'" do
    before do
      @params = {name: "tag", memo: "memo"}
      Tag.create(name: "newtag")
    end
    it "returns http success" do
      post 'create', @params
      expect(response).to redirect_to("back")
    end
    it "同名タグが無ければ追加する" do
      expect{post 'create', @params}.to change{Tag.count}.by(1)
    end
    it "同名タグがあればそちらを使う（新規作成しない）" do
      expect{post 'create', {name: "newtag"}}.to change{Tag.count}.by(0)
    end
  end

  describe "DELETE 'destroy'" do
    before do
      @params = {ticket_id: 1, tag_id: 1, id: 2}
    end
    it "returns http success" do
      delete 'destroy', @params
      expect(response).to redirect_to(request.env["HTTP_REFERER"]) 
    end
    it "削除できる(Taggingを削除することでTicketとTagの結合を解除する)" do
      delete 'destroy', @params
      expect(Tagging.count).to eq(3)
      expect(Tagging.find_by(@params)).to eq(nil)
    end
  end

end
