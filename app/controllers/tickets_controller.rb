class TicketsController < ApplicationController

  def index
    @active_cohort = Cohort.where(active: true).first
    @tickets = @active_cohort.systems.paginate(page: params[:page], :per_page => 12)
  end

  def show

  end
end