class TicketsController < ApplicationController

  def index
    @active_cohort = Cohort.where(active: true).first
    @tickets = @active_cohort.systems.order(:start_date, :title) unless @active_cohort.nil?
  end

  def show
    @ticket = System.find(params[:id])
    @registrant = Registrant.new(:system_id => @ticket.id)
  end

  def add_to_cart
    @ticket = System.find(params["id"])
    unless @ticket.cohort.active? && @ticket.cohort.registration_open?
      redirect_to tickets_path and return
    end
    @registrant = Registrant.new(:name => params[:registrant][:name], :email => params[:registrant][:email].strip!, :system_id => params["id"], :paid => false, :uuid => SecureRandom.uuid)
    if @ticket.full?
      flash[:warning] = "Unfortunately that system has sold out!"
      redirect_to tickets_path
    elsif @registrant.valid?
      registrants = Cart.decode_cart(cookies)
      registrants << @registrant
      cookies[:registrants] = Cart.encode_cart(registrants)
      flash[:success] = "Ticket added to cart."
      redirect_to cart_tickets_path
    else
      render :show
    end
  end

  def remove_from_cart
    registrants = Cart.decode_cart(cookies)
    registrants.delete_if { |registrant| registrant.uuid == params[:uuid] }
    cookies[:registrants] = Cart.encode_cart(registrants)
    redirect_to cart_tickets_path
  end

  def cart
    @registrants = Cart.decode_cart(cookies)
  end
end
