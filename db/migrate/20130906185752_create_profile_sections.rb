class CreateProfileSections < ActiveRecord::Migration
  def change
    create_table :profile_sections do |t|
      t.string :name

      t.timestamps
    end
  end
end
