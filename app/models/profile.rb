class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile_section

  serialize :properties, Hash

  def update_properties(params)
    profile_section = self.profile_section
    params.each do |key, value|
      next unless profile_section.fields.any? {|f| f.name == key}
      self.properties[key] = value
    end
  end

  def update_properties!(params)
    update_properties(params)
    self.save
  end
end
