class OpportunitiesController < ApplicationController
	def index
		@opportunities = HTTParty.get("http://mo.tynsax.com/api/registrations")
		
	end

	def show_mo
		@opportunity = HTTParty.get("http://mo.tynsax.com/api/registrations/#{params[:mo_id]}/full_map")
		# render :json => @opportunity
	end
end
