class Visit < ApplicationRecord
  belongs_to :patient

  validates_uniqueness_of :patient, :scope => [:date_of_service, :webptvisitid] # add discipline, or get discipline from looking up the discipline of the documenting therapist
end
