class OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: [:update, :move_to_next_stage, :destroy]

  def index
    opportunities = Opportunity.includes(:patient, :doctor)
    render_opportunities(opportunities)
  end

  def search
    query = params[:query].to_s.strip.downcase

    opportunities = OpportunitySearchService.search(query) 
    render_opportunities(opportunities)
  end
  
  def create
    @opportunity = Opportunity.new(opportunity_params)

    if @opportunity.save
      render_success(data: {message: "Opportunity added successfully"})
    else
      render_error(message: @opportunity.errors.full_messages.last)
    end
  end

  def update
    if @opportunity.update(opportunity_params)
      render_success(data: {message: "Opportunity updated successfully"})
    else
      render_error(message: @opportunity.errors.full_messages.last)
    end
  end

  def move_to_next_stage
    if @opportunity.move_to_next_stage
      render_success(data: {message: "Opportunity stage changed successfully"})
    else
      render_error(message: @opportunity.errors.full_messages.last)
    end
  end

  def destroy
    @opportunity.destroy
    render_success(data: {message: "Opportunity deleted successfully"})
  end

  private
    def set_opportunity
      @opportunity = Opportunity.find_by(id: params[:id])
      render_not_found(message: "No opportunity found", status: 404) if @opportunity.nil?
    end

    def opportunity_params
      params.require(:opportunity).permit(:procedure_name, :patient_id, :doctor_id, stage_history: [:stage_name, :timestamp]).tap do |processed_params|
        stage_history = processed_params[:stage_history]
    
        stage_history&.each { |history| history[:timestamp] = history[:timestamp].to_datetime if history[:timestamp].present? }
      end
    end

    def render_opportunities(opportunities)
      serialized_opportunities = opportunities.map { |opportunity| OpportunitySerializer.new(opportunity) }
      counts = OpportunityCounterService.count(opportunities)
      render_success(data: counts.merge(data: serialized_opportunities))
    end
end
