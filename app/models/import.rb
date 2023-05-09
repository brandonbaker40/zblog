class Import < ApplicationRecord
  has_one_attached :file

  enum report: [:webpt_documented_units, :ais_visit_history]

  validates :file, attached: true, content_type: 'csv'
end
