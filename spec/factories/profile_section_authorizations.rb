# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile_section_authorization do
    is_admin_approved false
    is_pra_pending false
    is_pra_approved false
    omb_control_no "MyString"
    pra_approved_on "2013-09-16 11:56:56"
    admin_approved_by ""
    timestamps "MyString"
  end
end
