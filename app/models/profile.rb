class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile_section

  serialize :properties, Hash
end
