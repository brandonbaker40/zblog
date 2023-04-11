class Patient < ApplicationRecord
  has_many_attached :documents
  has_many :visits 
  
end
