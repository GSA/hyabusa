class RenamePraNotApplicableColumn < ActiveRecord::Migration
  def change
    rename_column :profile_section_authorizations, :pra_not_applicable, :pra_applies
    change_column :profile_section_authorizations, :pra_applies, :boolean, :default => true
  end
end
