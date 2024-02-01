# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Find or create the patient
patient = Member.find_or_create_by!(
  role: :patient
) do |p|
  p.first_name = "Sam"
  p.last_name = "Smith"
  p.gender = "male"
  p.age = 25
end

# Find or create the doctor
doctor = Member.find_or_create_by!(
  role: :doctor
) do |d|
  d.first_name = "Harry"
  d.last_name = "Masters"
  d.gender = "male"
  d.age = 35
end

# Find or create the opportunity
opportunity = Opportunity.find_or_create_by(
  procedure_name: "Tummy Tuck",
  patient_id: patient.id,
  doctor_id: doctor.id
) do |opp|
  opp.stage_history = [{ stage_name: "lead", timestamp: Time.current }]
end
