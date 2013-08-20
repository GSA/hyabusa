require 'spec_helper'

describe "Home", :type => :feature do
  before do
    @user_attrs = {:name => 'Joe Citizen', :email => 'joe@citizen.org'}
  end

  context "when a user is logged in" do
    before do
      user = User.create!(@user_attrs)
      current_user = user
    end

    it 'should show them a link to find opportunities relevant to them' do
      visit '/'
      page.should have_content('Relevant to me')
    end
  end

  describe "Finding Opportunities", :type => :feature do
    context "when a user is logged in" do
      before do
        user = User.create!(@user_attrs)
        current_user = user
      end
    end
  end
end
