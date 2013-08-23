class OpportunitiesController < ApplicationController
	def index
		@opportunities = HTTParty.get(ENV['MODUS_OPERANDI_HOME']+"/api/operations")
	end

	def show_mo
		# @opportunity = HTTParty.get(ENV['MODUS_OPERANDI_HOME']+"/api/operations/#{params[:mo_id]}/map")
		# render :json => @opportunity
		
	end
end
