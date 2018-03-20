class InfosController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def show
    @info = Info.find(1)
  end

  def edit
    @info = Info.find(1)
  end

  def update
    @info = Info.find(1)
    if @info.update_attributes(info_params)
      flash[:success] = "Information updated"
    else
      flash[:warning] = "Something went wrong, try again"
    end
    redirect_to info_path(@info)
  end

  private

  def info_params
    params.require(:info).permit(:body)
  end
end
