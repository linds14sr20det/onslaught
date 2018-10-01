class SystemsController < ApplicationController
  before_action :logged_in_user

  def show
    @round_number = params[:round].to_i
    #TODO GET THE REAL PAIRINGS HERE
    @pairings = {current: [], previous: true}
    @system = System.find(params[:id])
    @registrants = @system.registrants.paid
  end

  def create_pairings
    system = System.find(params[:id])
    round_number = params[:round].to_i
    #TODO CREATE THE PAIRINGS HERE
    redirect_to system_path(system.id, { round: round_number })
  end
end
