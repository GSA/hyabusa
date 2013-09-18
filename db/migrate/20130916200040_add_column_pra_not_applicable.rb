class AddColumnPraNotApplicable < ActiveRecord::Migration
  def change
    add_column :profile_section_authorizations, :pra_not_applicable, :boolean
  end
end
