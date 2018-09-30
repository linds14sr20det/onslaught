class SystemsController < ApplicationController
  before_action :logged_in_user

  def show
    @system = System.find(params[:id])
    render
  end
end
