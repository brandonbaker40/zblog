class Visit < ApplicationRecord
  belongs_to :patient
  
  has_many :documented_units
  has_many :applied_codes, -> { distinct }, through: :documented_units, source: :code
  validates_uniqueness_of :patient, :scope => [:date_of_service, :webptvisitid] # add discipline, or get discipline from looking up the discipline of the documenting therapist
end
