class PatientSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :gender, :age, :avatar_url

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def avatar_url
    if object.avatar.attached?
      Rails.application.routes.url_helpers.url_for(object.avatar)
    else
      nil
    end
  end
end
