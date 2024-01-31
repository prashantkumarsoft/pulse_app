require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:gender) }
    it { should validate_presence_of(:role) }
  end

  describe 'associations' do
    it { should have_one_attached(:avatar) }
  end

  describe 'enums' do
    it { should define_enum_for(:gender).with_values(male: 0, female: 1) }
    it { should define_enum_for(:role).with_values(doctor: 0, patient: 1) }
  end
end
