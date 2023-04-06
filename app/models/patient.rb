class Patient < ApplicationRecord
  has_many_attached :documents
end
