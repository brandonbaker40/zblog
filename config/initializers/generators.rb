Rails.application.config.generators do |g|
    # default ID for all models is uuid
    g.orm :active_record, primary_key_type: :uuid
end