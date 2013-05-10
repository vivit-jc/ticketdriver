# encoding: utf-8

class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    @ticket = Ticket.find(@comment.ticket_id)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_ticket_path(@ticket.project_id,@ticket), notice: 'コメントを書き込みました' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { redirect_to project_ticket_path(@ticket.project_id,@ticket), notice: '書き込みに失敗した模様＞＜' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @ticket = Ticket.find(@comment.ticket_id)
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to project_ticket_path(@ticket.project_id,@ticket) }
      format.json { head :no_content }
    end
  end


end
