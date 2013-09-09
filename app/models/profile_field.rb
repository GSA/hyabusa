class ProfileField < ActiveRecord::Base
  belongs_to :profile_section
  FIELD_TYPES = %w[ text_field check_box ]

  after_initialize :set_default_type

  protected
  def set_default_type
    self.field_type ||= FIELD_TYPES.first
  end
end
