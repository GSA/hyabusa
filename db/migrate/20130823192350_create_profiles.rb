class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_email
      t.references :entity_type, index: true
      t.integer :num_employees

      t.timestamps
    end
  end
end
