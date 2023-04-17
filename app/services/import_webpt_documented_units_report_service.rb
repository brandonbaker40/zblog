class ImportWebptDocumentedUnitsReportService 
   def initialize(file) 
        @file = file
   end 

   def call 
        file = File.open(@file)
        CSV.open(file, 'r:bom|utf-8', headers: true) do |csv|
            csv.each do |row|
        
                # Create a patient if they do not already exist in the database
                patient_hash = {}
                patient_hash[:last_name] = row["Patient Name"].split(',').first 
                patient_hash[:first_name] = row["Patient Name"].split(',').last.strip
                new_patient = Patient.create(patient_hash) # uniqueness validation causes this to skip/fail when patient is already in the database
                patient = Patient.find_by(last_name: patient_hash[:last_name], first_name: patient_hash[:first_name])
        
                visit_hash = {}
                visit_hash[:patient] = patient
                visit_hash[:webptvisitid] = row["Visit ID"]

                date_split = row["Date of Service"].split("/")
                visit_hash[:date_of_service] = Date.parse((date_split[2]) + '-' + date_split[0] + '-' + date_split[1])
                # CSV examples: 4/1/22 12/19/22 1/2/23
        
                new_visit = Visit.create(visit_hash) 
                visit = Visit.find_by(visit_hash)

                
                code_hash = {} 
                code_hash[:label] = row["CPT Code"]
                new_code = Code.create(code_hash)
                code = Code.find_by(label: code_hash[:label])

                documented_unit_hash = {} 
                documented_unit_hash[:visit] = visit 
                documented_unit_hash[:code] = code 
                documented_unit_hash[:unit_count] = row["Units"]
                new_documented_unit = DocumentedUnit.create(documented_unit_hash)
                documented_unit = DocumentedUnit.find_by(visit: documented_unit_hash[:visit], code: documented_unit_hash[:code], unit_count: documented_unit_hash[:unit_count])

            end
        end
    end

end