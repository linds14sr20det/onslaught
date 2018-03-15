class TicketsController < ApplicationController

  def index
    @active_cohort = Cohort.where(active: true).first
    @tickets = @active_cohort.systems.paginate(page: params[:page], :per_page => 12)
  end

  def show
    @ticket = System.find(params[:id])
  end

  def add_to_cart
    ticket = System.find(params[:id])
    tickets = JSON.parse(cookies[:tickets])
    tickets = [] unless tickets.kind_of?(Array)
    tickets << ticket.to_json
    cookies[:tickets] = JSON.generate(tickets)
    redirect_to cart_index_path
  end
end