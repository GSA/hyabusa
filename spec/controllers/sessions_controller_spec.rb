require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
  	it "attempt to authenticate with MyUSA" do
  		get 'new'
  		response.should have_content "my.usa.gov"
  	end
  end

end
