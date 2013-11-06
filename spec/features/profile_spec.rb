require 'spec_helper'

describe "Profile", :type => :feature do
  before do
    @user_attrs = {:name => 'Joe Citizen', :email => 'joe@citizen.org'}
  end

  context "when a user goes to the profile page" do
    let(:user) do
      user = User.find_by_email(@user_attrs[:email]) || User.create!(@user_attrs)
    end

    context "the first time" do
      it 'should redirect them to the profile creation form' do
        login_with_myusa
        visit '/profile/edit'
        current_path.should == '/profile/new'
        page.should have_content("Create a profile to get started!")
      end
    end
  end

  context "when a user goes to the new profile page" do
    let(:user) do
      user = User.find_by_email(@user_attrs[:email]) || User.create!(@user_attrs)
    end

    it "should let them create a profile" do
      login_with_myusa
      visit '/profile/new'
      within("//form[@id=new_profile]") do
        fill_in "Company name", with: "ACME Widgets"
        fill_in "Address1", with: "123 Courthouse Rd."
        fill_in "City", with: "Philadelphia"
        select "Manufacturer", from: "Organization type"
        select "Pennsylvania", from: "State"
        choose "profile_export_type_us_produced"
        click_on "Create Profile"
      end

      current_path.should == '/profile'
      page.should have_content "Profile was successfully created"

      u = User.where(email: user.email).first

      u.profile.should_not be_nil
    end
  end
end

describe "BizUSAJSONStore", type: :feature do
  it "should return JSON store when requested" do
    pending("Hey, change this column back to type json once Travis adds support for Postgresql 9.2!")
  end
end
