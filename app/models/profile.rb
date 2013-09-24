class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity_type

  has_many :people, class_name: "ProfilePerson"
  accepts_nested_attributes_for :people, allow_destroy: true

  ORGANIZATION_TYPES = [
    'Cooperative/Consortium', 'Distributor', 'Education',
    'Educational Institution', 'Franchise', 'Importer',
    'Manufacturer', 'Minority-Owned', 'Reseller',
    'Service Provider', 'Trading', 'Wholesaler',
  ]

  US_STATES = Country['US'].states

  validates :org_type, inclusion: { in: ORGANIZATION_TYPES, message: "%{value} is not a valid organization type"}
  validates :state, inclusion: { in: US_STATES.map{|k,v| k}, message: '%{value} is not a valid US State'}

  def entity_type_name
    unless self.entity_type.nil?
      return self.entity_type.name
    else
      return ''
    end
  end

end
