class ProfileSectionAuthorization < ActiveRecord::Base
  belongs_to :profile_section

  validates_uniqueness_of :profile_section_id
end
