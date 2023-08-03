json.extract! worker, :id, :worker_type, :payroll_workerId, :work_email, :personal_email, :contact_phone, :date_of_birth, :profile_id, :created_at, :updated_at
json.url worker_url(worker, format: :json)
