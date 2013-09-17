class ProfileSection < ActiveRecord::Base
  has_many :fields, class_name: 'ProfileField'
  has_one :authorization, class_name: ProfileSectionAuthorization
  accepts_nested_attributes_for :fields, allow_destroy: true

  scope :admin_approved, -> { joins(:authorization).where(profile_section_authorizations: { is_admin_approved: true }) }
  scope :pra_approved, -> { joins(:authorization).where(profile_section_authorizations: { is_pra_approved: true }) }
  scope :user_fillable, -> { joins(:authorization).where(profile_section_authorizations: { pra_applies: true }) }

  def self.visible(sandbox=false)
    if sandbox
      self.admin_approved.user_fillable
    else
      self.admin_approved.pra_approved.user_fillable
    end
  end
end
