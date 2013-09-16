class ProfileSection < ActiveRecord::Base
  has_many :fields, class_name: 'ProfileField'
  has_one :profile_section
  accepts_nested_attributes_for :fields, allow_destroy: true
end
