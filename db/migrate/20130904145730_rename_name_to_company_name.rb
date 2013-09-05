class RenameNameToCompanyName < ActiveRecord::Migration
  def change
    rename_column :profiles, :name, :company_name
  end
end
