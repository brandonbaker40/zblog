class Visit < ApplicationRecord
  belongs_to :patient

  has_many :documented_units
  has_many :applied_codes, -> { distinct }, through: :documented_units, source: :code

  # validates_uniqueness_of :webptvisitid
  validates_uniqueness_of :patient, :scope => [:date_of_service, :webptvisitid] # add discipline, or get discipline from looking up the discipline of the documenting therapist
  validates :date_of_service, presence: true
  # validates :webptvisitid, , numericality: true

  validates :webptvisitid, presence: true, if: Proc.new { |v| v.webptvisitid.present? }
  validates :webptvisitid, uniqueness: true, if: Proc.new { |v| v.webptvisitid.present? }
  validates :webptvisitid, numericality: true, if: Proc.new { |v| v.webptvisitid.present? }

  



end
