class CreateProfileSectionAuthorizations < ActiveRecord::Migration
  def change
    create_table :profile_section_authorizations do |t|
      t.integer :profile_section_id
      t.boolean :is_admin_approved
      t.boolean :is_pra_pending
      t.boolean :is_pra_approved
      t.string :omb_control_no
      t.date :pra_approved_on

      t.timestamps
    end
  end
end
