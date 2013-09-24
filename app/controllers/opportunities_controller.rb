class OpportunitiesController < ApplicationController
	def index
		begin
			@opportunities = HTTParty.get(ENV['MODUS_OPERANDI_HOME']+"/api/operations")
		rescue
			@opportunities = []
			flash.now[:error] = 'The opportunities service is unreachable due to connectivity issues. Try again later.'
		end
	end

end
