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

  EXPORT_TYPE = [
    ['Goods or services produced in the United States', 'us_produced'],
    ['Goods or services that contain at least 51% US content', 'us_content'],
    ['None of the above', 'none']
  ]

  validates :org_type, inclusion: { in: ORGANIZATION_TYPES, message: "%{value} is not a valid organization type" }
  validates :state, inclusion: { in: US_STATES.map{|k,v| k}, message: "%{value} is not a valid US State" }
  validates :export_type, inclusion: { in: EXPORT_TYPE.map{|x| x.last}, message: "%{value} is not a valid export type" }

  def entity_type_name
    unless self.entity_type.nil?
      return self.entity_type.name
    else
      return ''
    end
  end

  def self.find_by_user_uid(uid)
    Profile.joins(:user).where("users.uid = '#{uid}'").first
  end
end
