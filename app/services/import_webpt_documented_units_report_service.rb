class ImportWebptDocumentedUnitsReportService
  require 'csv'
  require 'open-uri'

   def initialize(file)
        @file = file
   end

   def call
    # CSV.parse is used in favor of CSV.open because CSV.parse can manipulate StringIO content type
    # URI.open is used since that is what is recommended as of ruby 3.0... and nothing else I tried worked
    # liberal_parsing is set to true to ignore non UTF-8 characters like BOM
    # headers == TRUE because it's useful
    # header_converters converted to symbol is necessary to remove the BOM from the keys when the row is converted to a hash
      CSV.parse(URI.open(@file), liberal_parsing: true, headers: true, header_converters: :symbol).each do |row|
        row = row.to_h

        patient_hash = {}
          patient_hash[:last_name] = row[:patient_name].split(',').first
          patient_hash[:first_name] = row[:patient_name].split(',').last.strip
          new_patient = Patient.create(patient_hash) # uniqueness validation causes this to skip/fail when patient is already in the database
          patient = Patient.find_by(last_name: patient_hash[:last_name], first_name: patient_hash[:first_name])

        visit_hash = {}
          visit_hash[:patient] = patient
          visit_hash[:webptvisitid] = row[:visit_id]

        date_split = row[:date_of_service].split("/")
          visit_hash[:date_of_service] = Date.parse((date_split[2]) + '-' + date_split[0] + '-' + date_split[1])
          # CSV examples: 4/1/22 12/19/22 1/2/23
          new_visit = Visit.create(visit_hash)
          visit = Visit.find_by(visit_hash)

        code_hash = {}
          code_hash[:label] = row[:cpt_code]
          new_code = Code.create(code_hash)
          code = Code.find_by(label: code_hash[:label])

        documented_unit_hash = {}
          documented_unit_hash[:visit] = visit
          documented_unit_hash[:code] = code
          documented_unit_hash[:unit_count] = row[:units]
          new_documented_unit = DocumentedUnit.create(documented_unit_hash)
          documented_unit = DocumentedUnit.find_by(visit: documented_unit_hash[:visit], code: documented_unit_hash[:code], unit_count: documented_unit_hash[:unit_count])

      end

    end

end
