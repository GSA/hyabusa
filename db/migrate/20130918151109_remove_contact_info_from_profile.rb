class RemoveContactInfoFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :contact_first_name
    remove_column :profiles, :contact_last_name
    remove_column :profiles, :contact_email
  end
end
