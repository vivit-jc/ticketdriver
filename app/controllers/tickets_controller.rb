# encoding: utf-8

class TicketsController < ApplicationController
  include TicketsHelper
  before_filter :basic_auth

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.where(:finished => false, :project_id => @project.id)
    if(params[:sort])
      case params[:sort]
      when "priority"
        @tickets = @tickets.order("priority DESC") if(!params[:asc])
        @tickets = @tickets.order("priority ASC") if(params[:asc])
      when "updated_at"
        @tickets = @tickets.order("updated_at DESC") if(!params[:asc])
        @tickets = @tickets.order("updated_at ASC") if(params[:asc])
      end
    else
      @tickets = @tickets.order("updated_at DESC")
    end
    @tickets_finished = Ticket.where(:finished => true, :project_id => @project.id).limit(10).order("updated_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])
    @comments = @ticket.comments
    @new_comment = Comment.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  def show_more
    @tickets = Ticket.where(:finished => true, :project_id => @project.id).order("updated_at DESC")
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def new
    @ticket = Ticket.new
    make_select
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
    make_select
    @status_array = []
    2.times do |i|
      @status_array.push([Ticket::get_status_no(i),i])
    end

    @priority_array = []
    5.times do |i|
      @priority_array.push([Ticket::get_priority_no(i),i])
    end

  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(params[:ticket])

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to project_tickets_path, notice: 'チケットが作成されました' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to project_ticket_path(@ticket.project_id,@ticket), notice: 'チケットが更新されました' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to project_tickets_path }
      format.json { head :no_content }
    end
  end
  
  
  def manual
  end

  def lift
    tickets = Ticket.find(:all, :conditions => {:project_id => @project.id, :finished => false})
    tickets.each_with_index do |t,i|
      if(t.id == params[:id].to_i && i > 0)
        exchange(tickets[i],tickets[i-1])
        break
      end
    end
    redirect_to project_tickets_path
  end

  def lower
    tickets = Ticket.find(:all, :conditions => {:project_id => @project.id, :finished => false})
    tickets.each_with_index do |t,i|
      if(t.id == params[:id].to_i && i < tickets.size-1)
        exchange(tickets[i],tickets[i+1])
        break
      end
    end
    redirect_to project_tickets_path
  end

end
