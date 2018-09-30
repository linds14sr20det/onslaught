class SystemsController < ApplicationController
  before_action :logged_in_user

  def show
    @round_number = params[:round].to_i
    @pairings = []
    @system = System.find(params[:id])
    @registrants = @system.registrants.paid
  end
end
