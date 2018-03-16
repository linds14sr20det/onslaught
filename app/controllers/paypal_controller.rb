require 'paypal-sdk-rest'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging

class PaypalController < ApplicationController
  skip_before_action :verify_authenticity_token

  def checkout
    registrants = JSON.parse(params["registrants"])
    registrants.map!{|registrant| Registrant.new(registrant)}
    items = []
    registrants.each do |registrant|
      items << {
          :name => registrant.system.title,
          :sku => registrant.system.id,
          :price => registrant.system.cost,
          :currency => "CAD",
          :quantity => 1,
      }
    end

    total = items.map { |item| item[:price] }.sum

    @payment = Payment.new({
    :intent =>  "sale",
    # ###Payer
    # A resource representing a Payer that funds a payment
    # Payment Method as 'paypal'
    :payer => { :payment_method =>  "paypal" },
    # ###Redirect URLs
    :redirect_urls => {
      :return_url => execute_url,
      :cancel_url => tickets_url
    },
    # ###Transaction
    # A transaction defines the contract of a
    # payment - what is the payment for and who
    # is fulfilling it.
    :transactions => [{
    # Item List
    :item_list => {:items => items},

    # ###Amount
    # Let's you specify a payment amount.
    :amount =>  {
      :total =>  total,
      :currency =>  "CAD" },
    :description =>  "Purchase of event tickets for Onslaught." }]})

    # Create Payment and return status
    if @payment.create
      render json: {success: true, paymentID: @payment.id}
    else
      render json: {success: false}
    end
  end

  def execute
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
    if payment.execute(payer_id: params[:PayerID])
      render json: {msg: 'Payment Complete'}
    else
      render json: {msg: payment.error}
    end
  end
end