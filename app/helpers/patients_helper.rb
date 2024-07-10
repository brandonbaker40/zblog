module PatientsHelper
    def patient_full_name(patient)
        patient.last_name + ", " + patient.first_name
    end
end
