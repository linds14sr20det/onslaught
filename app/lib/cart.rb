class Cart
  def self.badge_count(cookies)
    count = decode_cart(cookies).count
    return "cart-badge-max" if count > 5
    "cart-badge-#{count}"
  end

  def self.decode_cart(cookies)
    registrants = []
    unless cookies[:registrants].nil?
      JSON.parse(cookies[:registrants]).each do |registrant|
        registrants << Registrant.new(JSON.parse(registrant))
      end
    end
    registrants
  end

  def self.encode_cart(registrants)
    JSON.generate(registrants.map!{|registrant| registrant.to_json})
  end
end