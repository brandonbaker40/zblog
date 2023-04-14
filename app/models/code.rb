class Code < ApplicationRecord
    
    # has_many :visits, -> { distinct }, through: :documented_units
    has_many :documented_units
    has_many :billed_visits, -> { distinct }, through: :documented_units, source: :visit

    validates_uniqueness_of :label
end
