require 'spec_helper'

describe "Home", :type => :feature do
  before do
    @user_attrs = {:name => 'Joe Citizen', :email => 'joe@citizen.org'}
    @profile_attrs = { :num_employees => 40, :company_name => 'Go Go Gadgets', :address1 => '4000 Park Ave', :city => 'Washington', :state => 'DC', :postal_code => '20009', :org_type => "Service Provider" }
  end

  context "when a user is logged in" do

    it "show the user's business profile" do
      login_with_myusa
      profile = Profile.new(@profile_attrs)
      profile.user = current_user
      profile.save
      visit '/'
      page.should have_content('My BusinessUSA Profile')
    end
  end
end
