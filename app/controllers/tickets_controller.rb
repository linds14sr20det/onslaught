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
    @registrant = Registrant.new(:name => params[:registrant][:name], :email => params[:registrant][:email], :system_id => params["id"], :paid => false, :uuid => SecureRandom.uuid)
    if @ticket.full?
      flash[:warning] = "Unfortunately that system has sold out!"
      redirect_to tickets_path
    elsif @registrant.valid?
      registrants = decode_cart
      registrants << @registrant
      encode_cart(registrants)
      flash[:success] = "Ticket added to cart."
      redirect_to cart_tickets_path
    else
      render :show
    end
  end

  def remove_from_cart
    registrants = decode_cart
    registrants.delete_if { |registrant| registrant.uuid == params[:uuid] }
    encode_cart(registrants)
    redirect_to cart_tickets_path
  end

  def cart
    @registrants = decode_cart
  end

  private

  def decode_cart
    registrants = []
    unless cookies[:registrants].nil?
      JSON.parse(cookies[:registrants]).each do |registrant|
        registrants << Registrant.new(JSON.parse(registrant))
      end
    end
    registrants
  end

  def encode_cart(registrants)
    cookies[:registrants] = JSON.generate(registrants.map!{|registrant| registrant.to_json})
  end
end