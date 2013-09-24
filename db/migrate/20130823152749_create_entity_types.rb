class CreateEntityTypes < ActiveRecord::Migration
  def change
    create_table :entity_types do |t|
      t.string :name
      t.string :description
      t.string :supertype

      t.timestamps
    end
  end
end
