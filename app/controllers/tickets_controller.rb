class TicketsController < ApplicationController

  def index
    @active_cohort = Cohort.where(active: true).first
    @tickets = @active_cohort.systems.order(:start_date, :title) unless @active_cohort.nil?
  end

  def show
    @ticket = System.find(params[:id])
  end

  def add_to_cart
    if System.find(params["id"]).full?
      flash[:warning] = "Unfortunately that system has sold out!"
      redirect_to tickets_path
    else
      registrants = decode_cart
      registrants << Registrant.new(:name => params["name"], :email => params["email"], :system_id => params["id"], :paid => false, :uuid => SecureRandom.uuid)
      encode_cart(registrants)
      redirect_to cart_tickets_path
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