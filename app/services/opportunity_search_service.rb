class OpportunitySearchService
  def self.search(query)
    Opportunity.includes(:patient, :doctor)
              .joins('LEFT JOIN members AS patients ON opportunities.patient_id = patients.id')
              .joins('LEFT JOIN members AS doctors ON opportunities.doctor_id = doctors.id')
              .where('LOWER(procedure_name) LIKE ? OR LOWER(patients.first_name) LIKE ? OR LOWER(patients.last_name) LIKE ? OR LOWER(doctors.first_name) LIKE ? OR LOWER(doctors.last_name) LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
