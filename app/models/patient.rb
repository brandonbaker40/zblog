class Patient < ApplicationRecord
  before_save :set_default_name

  has_many_attached :documents
  has_many :visits

  has_many :patient_entities, dependent: :destroy, inverse_of: :patient
  has_many :engaged_provider_organizations, -> { distinct }, through: :patient_entities, :source => :provider_organization

  enum sex: [:male, :female]

  validates_uniqueness_of :last_name, :scope => [:first_name] # add Date of Birth when the field is added in a migration

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :birthdate, presence: true
  # validates :sex, presence: true


  def self.ransackable_attributes(auth_object = nil)
    ["id", "first_name", "last_name", "name", "birthdate", "sex", "created_at", "updated_at"]
  end

  def set_default_name
    self.name ||= "#{self.last_name}, #{self.first_name}"
  end
end
