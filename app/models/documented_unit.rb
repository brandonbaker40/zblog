class DocumentedUnit < ApplicationRecord
  belongs_to :code
  belongs_to :visit
end
