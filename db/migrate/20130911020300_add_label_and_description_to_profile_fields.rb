class AddLabelAndDescriptionToProfileFields < ActiveRecord::Migration
  def change
    add_column :profile_fields, :label, :string
    add_column :profile_fields, :description, :text
  end
end
