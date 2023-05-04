class Import < ApplicationRecord
  has_one_attached :file

  validates :file, attached: true, content_type: 'csv'
end
