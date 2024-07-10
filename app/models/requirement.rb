class Requirement < ApplicationRecord
    has_many :credentials, dependent: :destroy
    has_many :required_profiles, -> { distinct }, through: :credentials, :source => :profile
end
