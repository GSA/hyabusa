class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity_type

  has_many :profile_people

  validates :org_type, inclusion: { :in => [
    'Cooperative/Consortium', 'Distributor', 'Education',
    'Educational Institution', 'Franchise', 'Importer',
    'Manufacturer', 'Minority-Owned', 'Reseller',
    'Service Provider', 'Trading', 'Wholesaler',
  ],
  message: "%{value} is not a valid organization type"}

end
