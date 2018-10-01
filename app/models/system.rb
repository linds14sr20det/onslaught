class System < ApplicationRecord
  belongs_to :cohort, inverse_of: :systems
  has_one :attachment, inverse_of: :system
  has_many :registrants, :dependent => :restrict_with_error
  has_many :pairings
  accepts_nested_attributes_for :attachment, reject_if: :all_blank, allow_destroy: true
  before_destroy :check_for_registrants
  validates :rounds, presence:true, numericality: {less_than_or_equal_to: 15}

  def first_image
    html = Nokogiri::HTML.fragment(description)
    image = ActionController::Base.helpers.asset_path("onslaughtlogo.png", :digest => false)
    image = html.css('img')[0].attr('src') unless html.css('img')[0].nil?
    image
  end

  def full?
    registrants.paid.count >= max_players
  end

  def generate_pairings(round_number)
    player_order = registrants.shuffle if round_number == 1
    #TODO need to get an ordered list without players who have played each other in order of wld.
    player_order.each_slice(2) do | player_1, player_2 |
      pairings.create(player_one_id: player_1.id, player_two_id: player_2.id, round: round_number)
    end
    pairings.round(round_number)
  end

  def get_round_pairings(round_number)
    previous = true if round_number == 1 || !pairings.round(round_number - 1).empty?
    pairing_list = pairings.round(round_number)
    { current: pairing_list, previous: previous }
  end

  private

  def check_for_registrants
    if registrants.count > 0
      errors.add(:active, 'cannot have another active cohort. Deactivate the active cohort.')
      false
    end
  end
end
