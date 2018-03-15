class CartController < ApplicationController

  def index
    @tickets = []
    JSON.parse(cookies[:tickets]).each do |ticket|
      @tickets << System.new(JSON.parse(ticket))
    end
  end
end