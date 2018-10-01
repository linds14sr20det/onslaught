class SystemsController < ApplicationController
  before_action :logged_in_user

  def show
    @round_number = params[:round].to_i
    @system = System.find(params[:id])
    @pairings = @system.get_round_pairings(@round_number)
    @registrants = @system.registrants.paid
  end

  def generate_pairings
    system = System.find(params[:id])
    round_number = params[:round].to_i
    system.generate_pairings(round_number)
    redirect_to system_path(system.id, { round: round_number })
  end
end
