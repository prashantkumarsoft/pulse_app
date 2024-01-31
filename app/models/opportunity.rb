class Opportunity < ApplicationRecord
  validates :procedure_name, presence: true

  belongs_to :patient, class_name: 'Member', foreign_key: 'patient_id'
  belongs_to :doctor, class_name: 'Member', foreign_key: 'doctor_id'

  def move_to_next_stage
    next_stage = next_stage_name(current_stage)
    return true if next_stage == current_stage
    stage_history << { stage_name: next_stage, timestamp: Time.current } 

    save
  end

  def next_stage_name(current_stage_name)
    case current_stage_name
    when 'lead'
      'qualified'
    when 'qualified'
      'booked'
    when 'booked'
      'treated'
    else
      current_stage_name
    end
  end

  def current_stage
    stage_history&.last&.dig("stage_name")&.downcase
  end
end
