class EntityType < ActiveRecord::Base
=begin
This classs is primarily for populating the business profile,
and was based on a field from new.export.gov's registration.
=end

  validates_uniqueness_of :name
  validates_presence_of :name
end
