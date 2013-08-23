class CreateProfilePeople < ActiveRecord::Migration
  def change
    create_table :profile_people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :title
      t.string :phone_work
      t.string :phone_mobile

      t.timestamps
    end
  end
end
