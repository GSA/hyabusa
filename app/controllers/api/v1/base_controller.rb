class Api::V1::BaseController < ApplicationController
	def index
		respond_to do |format|
      format.xml  {  }
      format.json { render :json => { :hi => 'there' } }
    end
	end
end
