class Cohort < ApplicationRecord
  has_many :systems, dependent: :destroy
  #TODO: validate start is before end
  accepts_nested_attributes_for :systems, reject_if: :all_blank, allow_destroy: true
end
