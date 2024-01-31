class OpportunityCounterService
  def self.count(opportunities)
    counts = {
      lead_stage_count: 0,
      qualified_stage_count: 0,
      booked_stage_count: 0,
      treated_stage_count: 0
    }

    opportunities.each do |opportunity|
      case opportunity.current_stage
      when "lead"
        counts[:lead_stage_count] += 1
      when "qualified"
        counts[:qualified_stage_count] += 1
      when "booked"
        counts[:booked_stage_count] += 1
      when "treated"
        counts[:treated_stage_count] += 1
      end
    end

    counts
  end
end
