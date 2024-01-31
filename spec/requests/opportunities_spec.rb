require 'rails_helper'

RSpec.describe "Opportunities", type: :request do
  let!(:patient) { create(:member, role: "patient") }
  let!(:doctor) { create(:member, role: "doctor") }
  let!(:opportunity) { create(:opportunity, procedure_name: 'example', stage_history: [{ stage_name: 'lead', timestamp: Time.current }], patient: patient, doctor: doctor) }

  describe 'GET #index' do
    it 'returns a success response' do
      get '/opportunities'
      expect(response).to be_successful

      serialized_opportunities = [OpportunitySerializer.new(opportunity).as_json.with_indifferent_access]
      expect(JSON.parse(response.body)['data']).to match_array(serialized_opportunities)
    end
  end

  describe 'GET #search' do
    it 'returns a success response' do
      get '/opportunities/search', params: { query: 'example' }
      expect(response).to be_successful

      serialized_opportunities = [OpportunitySerializer.new(opportunity).as_json.with_indifferent_access]
      expect(JSON.parse(response.body)['data']).to match_array(serialized_opportunities)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new opportunity' do
        opportunity_params = FactoryBot.attributes_for(:opportunity, patient_id: patient.id, doctor_id: doctor.id)
        expect {
          post '/opportunities', params: { opportunity: opportunity_params }
        }.to change(Opportunity, :count).by(1)
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new opportunity' do
        invalid_opportunity_params = FactoryBot.attributes_for(:opportunity, procedure_name: nil)
        expect {
          post '/opportunities', params: { opportunity: invalid_opportunity_params }
        }.not_to change(Opportunity, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the opportunity' do
        patch "/opportunities/#{opportunity.id}", params: { opportunity: { procedure_name: 'New Procedure' } }
        opportunity.reload
        expect(opportunity.procedure_name).to eq('New Procedure')
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      it 'renders an error response' do
        patch "/opportunities/#{opportunity.id}", params: { opportunity: { procedure_name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #move_to_next_stage' do
    it 'moves the opportunity to the next stage' do
      patch "/opportunities/#{opportunity.id}/move_to_next_stage"
      opportunity.reload
      expect(opportunity.current_stage).to eq('qualified')
      expect(response).to be_successful
    end
  end

  describe 'DELETE #destroy' do
    let!(:opportunity_to_delete) { create(:opportunity) }

    it 'destroys the requested opportunity' do
      expect {
        delete "/opportunities/#{opportunity_to_delete.id}"
      }.to change(Opportunity, :count).by(-1)
      expect(response).to be_successful
    end
  end
end
