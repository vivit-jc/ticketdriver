# encoding: utf-8

require 'spec_helper'

describe Ticket do
  before do
    @ticket = FactoryGirl.create(:ticket)
    3.times{@ticket.tags.create}
  end

  it "タグが取得できる" do
    expect(@ticket.tags.size).to eq(3)
  end

end
