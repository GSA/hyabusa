require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
  	it "attempts to authenticate with MyUSA" do
  		visit 'new'
        save_and_open_page
  		response.should have_content "my.usa.gov"
  	end
  end

end
