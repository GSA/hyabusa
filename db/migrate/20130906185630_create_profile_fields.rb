class CreateProfileFields < ActiveRecord::Migration
  def change
    create_table :profile_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.belongs_to :profile_section

      t.timestamps
    end
  end
end
