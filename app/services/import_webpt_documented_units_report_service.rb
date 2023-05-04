class ImportWebptDocumentedUnitsReportService
  include CsvHeaderValidator

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
    # handle_asynchronously :call below this method delegates this method to a background worker
      CSV.parse(URI.open(@file), liberal_parsing: true, headers: true, header_converters: :symbol).each_with_index do |row, index|
        row = row.to_h

        # break the csv loop and stop the import if the csv headers arent what they should be
        break if (index == 0 && (row.keys != CsvHeaderValidator::WEBPT_DOCUMENTED_UNITS_REPORT_CSV_HEADERS))

        # considered find_or_create_by and create_or_find_by
        patient_hash = {}
          patient_hash[:last_name] = row[:patient_name].split(',').first
          patient_hash[:first_name] = row[:patient_name].split(',').last.strip

          dob_split = row[:patient_dob].split("/")
            patient_hash[:birthdate] = Date.parse((dob_split[2]) + '-' + dob_split[0] + '-' + dob_split[1])
          patient = Patient.where(patient_hash).first_or_create

        visit_hash = {}
          visit_hash[:patient] = patient
          visit_hash[:webptvisitid] = row[:visit_id]

        dos_split = row[:date_of_service].split("/")
          visit_hash[:date_of_service] = Date.parse((dos_split[2]) + '-' + dos_split[0] + '-' + dos_split[1])
          visit = Visit.where(visit_hash).first_or_create

        code_hash = {}
          code_hash[:label] = row[:cpt_code]
          code = Code.where(code_hash).first_or_create

        documented_unit_hash = {}
          documented_unit_hash[:visit] = visit
          documented_unit_hash[:code] = code
          documented_unit_hash[:unit_count] = row[:units]
          documented_unit = DocumentedUnit.where(documented_unit_hash).first_or_create

      end

    end
    handle_asynchronously :call

end
