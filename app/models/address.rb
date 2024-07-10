class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates_presence_of :streetLineOne, :city, :state, :zip_code

  validates_format_of :zip_code, with: /\A\d{5}\z/
  validates :zip_code, numericality: true

  validates :state, length: { is: 2 }
  validates_format_of :state, with: /\A(?-i:A[LKZR]|C[AOT]|D[EC]|F[L]|G[A]|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|PA|RI|S[CD]|T[NX]|UT|V[AT]|W[AIVY])\z/
end
