class Patient < ApplicationRecord
  has_many_attached :documents
  has_many :visits

  validates_uniqueness_of :last_name, :scope => [:first_name] # add Date of Birth when the field is added in a migration

  def self.ransackable_attributes(auth_object = nil)
    ["birthdate", "created_at", "first_name", "id", "last_name", "sex", "updated_at"]
  end
end
