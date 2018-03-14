class System < ApplicationRecord
  belongs_to :cohort
  has_one :attachment, inverse_of: :system
  accepts_nested_attributes_for :attachment, reject_if: :all_blank, allow_destroy: true

  def first_image
    html = Nokogiri::HTML.fragment(description)
    image = ActionController::Base.helpers.asset_path("onslaughtlogo.png", :digest => false)
    image = html.css('img')[0].attr('src') unless html.css('img')[0].nil?
    image
  end
end
