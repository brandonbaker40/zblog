class ImportAisVisitHistoryService
  def initialize(s3_url)
    @s3_url = s3_url
  end

  def call
    CSV.parse(URI.open(@s3_url), liberal_parsing: true, headers: true, header_converters: :symbol).each_with_index do |row, index|
      row = row.to_h

      break if (index == 0 && (row.keys != CsvHeaderValidator::AIS_VISIT_HISTORY_REPORT_CSV_HEADERS))

      next if row[:agencynameforvisit] == ("HCRN" || "HCRN Private Pay")

      patient_hash = {}
        patient_hash[:last_name] = row[:lastname].strip
        patient_hash[:first_name] = row[:firstname].strip
        patient = Patient.where(patient_hash).first_or_create.save(validate: false) # saving without a birthdate

      visit


    end
  end
end
