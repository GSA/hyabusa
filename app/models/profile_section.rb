class ProfileSection < ActiveRecord::Base
  has_many :fields, class_name: 'ProfileField'
  accepts_nested_attributes_for :fields, allow_destroy: true
end
