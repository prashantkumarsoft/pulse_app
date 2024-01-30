class CreateOpportunities < ActiveRecord::Migration[7.0]
  def change
    create_table :opportunities do |t|
      t.string :procedure_name
      t.integer :patient_id
      t.integer :doctor_id
      t.jsonb :stage_history

      t.timestamps
    end
  end
end
