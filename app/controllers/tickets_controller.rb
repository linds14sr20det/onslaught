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
    cookies[:my_data] = {
        :value => ticket.to_json,
        :expires => 1.day.from_now
    }
    redirect_to tickets_path
  end
end