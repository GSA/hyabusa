class AssocProfilePersonWProfile < ActiveRecord::Migration
  def change
    add_reference(:profile_people, :profile)
  end
end
