class Profile < ActiveRecord::Base
  belongs_to :entity_type

  has_many :profile_people
end
