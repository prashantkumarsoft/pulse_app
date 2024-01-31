require 'rails_helper'

RSpec.describe Opportunity, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:procedure_name) }
  end

  describe 'associations' do
    it { should belong_to(:patient).class_name('Member').with_foreign_key('patient_id') }
    it { should belong_to(:doctor).class_name('Member').with_foreign_key('doctor_id') }
  end

  describe '#move_to_next_stage' do
    let(:opportunity) { create(:opportunity, stage_history: [{ stage_name: 'lead', timestamp: Time.current }]) }

    it 'moves to the next stage' do
      expect { opportunity.move_to_next_stage }.to change { opportunity.stage_history.size }.by(1)
      expect(opportunity.current_stage).to eq('qualified')
    end

    it 'does not change stage if already in the last stage' do
      opportunity.update(stage_history: [{stage_name: 'treated', timestamp: Time.current}])
      expect { opportunity.move_to_next_stage }.not_to change { opportunity.stage_history.size }
    end
  end

  describe '#next_stage_name' do
    it 'returns the next stage name correctly' do
      expect(Opportunity.new.next_stage_name('lead')).to eq('qualified')
      expect(Opportunity.new.next_stage_name('qualified')).to eq('booked')
      expect(Opportunity.new.next_stage_name('booked')).to eq('treated')
      expect(Opportunity.new.next_stage_name('treated')).to eq('treated')
    end
  end

  describe '#current_stage' do
    it 'returns the current stage name correctly' do
      opportunity = create(:opportunity, stage_history: [{ stage_name: 'lead', timestamp: Time.current }])
      expect(opportunity.current_stage).to eq('lead')
    end

    it 'returns nil if stage history is empty' do
      opportunity = create(:opportunity, stage_history: [])
      expect(opportunity.current_stage).to be_nil
    end
  end
end
