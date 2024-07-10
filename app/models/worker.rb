class Worker < ApplicationRecord
  belongs_to :profile

  enum worker_type: [:employee, :contractor, :vendor]

end
