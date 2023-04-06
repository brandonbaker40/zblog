json.extract! patient, :id, :first_name, :last_name, :documents, :created_at, :updated_at
json.url patient_url(patient, format: :json)
json.documents do
  json.array!(patient.documents) do |document|
    json.id document.id
    json.url url_for(document)
  end
end
