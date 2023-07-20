class Profile < ApplicationRecord

  enum role: [:provider, :admin, :dual]
end
