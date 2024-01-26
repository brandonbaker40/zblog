class Credential < ApplicationRecord
  belongs_to :requirement
  belongs_to :profile
end
