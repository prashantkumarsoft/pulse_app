class OpportunitySerializer < ActiveModel::Serializer
  attributes :id, :procedure_name, :stage_history, :current_stage

  belongs_to :patient, serializer: PatientSerializer
  belongs_to :doctor, serializer: DoctorSerializer

  def current_stage
    object.current_stage
  end
end
