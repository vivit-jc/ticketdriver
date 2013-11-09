# encoding: utf-8

class TagsController < ApplicationController
  before_action { |c| basic_auth(params[:project_id]) }

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @tickets = @tag.tickets
  end

  def create
    @tag = Tag.find_by(name: params[:name])
    @tag = Tag.create(name: params[:name]) if(!@tag)
    @tagging = Tagging.new(:ticket_id => params[:ticket_id], :tag_id => @tag.id)
    respond_to do |format|
      if(@tagging.save)
        format.html { redirect_to :back, notice: 'タグを追加しました' }
        format.json { render :json, status: :success }
      else
        format.html { redirect_to :back, notice: 'タグの追加に失敗しました' }
        format.json { render json: @tagging.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tagging = Tagging.find_by(ticket_id: params[:ticket_id], tag_id: params[:id])
    @tagging.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'タグを削除しました' }
      format.json { head :no_content }
    end
  end
end
