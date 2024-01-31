class MembersController < ApplicationController
  def create
    @member = Member.new(member_params)

    if @member.save
      render_success(data: {message: "Member added successfully"})
    else
      render_error(message: @member.errors.full_messages.last)
    end
  end

  def doctors
    render json: Member.doctor, each_serializer: DoctorSerializer, status: :ok
  end

  def patients
    render json: Member.patient, each_serializer: PatientSerializer, status: :ok
  end

  private

    def member_params
      params.require(:member).permit(:first_name, :last_name, :gender, :age, :role, :avatar)
    end
end
