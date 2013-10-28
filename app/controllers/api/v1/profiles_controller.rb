class Api::V1::ProfilesController < ApplicationController
	before_filter :oauthorize_request

	swagger_controller :profiles, "Business Profile Management"

  swagger_api :index do
    summary "Fetches all Profiles"
    # param :query, :page, :integer, :optional, "Page number"
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :show do
    summary "Fetches a single Profile item"
    param :path, :id, :integer, :optional, "Profile ID"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  swagger_api :update do
    summary "Updates an existing Profile"
    param :path, :id, :integer, :required, "Profile ID"
    param :form, :business_name, :string, :optional, "Business name"
    response :unauthorized
    response :not_found
    response :not_acceptable
  end


	def index
		render :json => Profile.find_by_user(@current_user)
	end

	def show
		# TODO
	end
end
