class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.references :profile_section, index: true
      t.string :properties

      t.timestamps
    end
  end
end
