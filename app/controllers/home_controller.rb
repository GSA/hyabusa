class HomeController < ApplicationController
  def index
  	if user_signed_in?
    	@profile = current_user.profile || Profile.new
    else
    	@profile = Profile.new
    end
  end
end
