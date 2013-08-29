require 'spec_helper'

describe ProfilesController do

  describe "GET '/profile'" do
    context "when a user is logged in" do
      before do
        login_with_myusa
      end

      it "returns http success" do
        visit '/profile'
        response.should be_success
        response.body.should have_content('My BusinessUSA Profile')
      end
    end
  end
end
