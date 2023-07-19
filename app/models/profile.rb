class Profile < ApplicationRecord
  belongs_to :user

  enum role: [:provider, :admin, :dual]
end
