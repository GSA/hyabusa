class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity_type

  has_many :profile_people

  ORGANIZATION_TYPES = [
    'Cooperative/Consortium', 'Distributor', 'Education',
    'Educational Institution', 'Franchise', 'Importer',
    'Manufacturer', 'Minority-Owned', 'Reseller',
    'Service Provider', 'Trading', 'Wholesaler',
  ]

  US_STATES = Country['US'].states

  validates :org_type, inclusion: { in: ORGANIZATION_TYPES, message: "%{value} is not a valid organization type"}
  validates :state, inclusion: { in: US_STATES.map{|k,v| k}, message: '%{value} is not a valid US State'}

end
