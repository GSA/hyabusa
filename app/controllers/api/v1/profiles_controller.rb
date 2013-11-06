class Api::V1::ProfilesController < ApplicationController
	before_filter :oauthorize_request, :except => :index

	# swagger_controller :profiles, "Business Profile Management"

 #  swagger_api :index do
 #    summary "Fetches user's Business Profile"
 # 		param :query, :uid, :string, :required, "User ID"
 #    response :unauthorized
 #    response :not_found
 #  end

 #  swagger_api :show do
 #    summary "Fetches a single Business Profile item by profile ID"
 #    param :profile, :id, :integer, :optional, "Profile ID"
 # 		param :query, :uid, :string, :required, "User ID"
 #    response :unauthorized
 #    response :not_found
 #  end

 #  swagger_api :update do
 #    summary "Updates an existing Business Profile"
 #    param :query, :uid, :string, :required, "User ID"
 #    param :profile, :id, :integer, :required, "Profile ID"
 #    param :profile, :company_name, :string, :optional, "Company name"
 #    response :unauthorized
 #    response :not_found
 #    response :not_acceptable
 #  end

 # 	swagger_api :create do
 #    summary "Creates a new Business Profile"
 #    param :query, :uid, :string, :required, "User ID"
 #    param :query, :profile, :hash, :required, "Profile hash"
 #    response :unauthorized
 #    response :not_acceptable
 #  end

 #  swagger_api :destroy do
 #    summary "Deletes an existing Business Profile"
 #    param :path, :id, :integer, :required, "Profile ID"
 #    param :query, :uid, :string, :required, "User ID"
 #    response :unauthorized
 #    response :not_found
 #  end

	def index
		# TODO: update
		if params[:uid] # we challenge the UID and the access token
			@profiles = Profile.find_by_user_uid(params[:uid])
			render :json => { :profiles => @profiles }
		elsif params[:uid].nil?
			render :json => { :errors => true, :message => "Unauthorized" }, :status => 403
		else
			render :json => { :errors => true, :message => "Unknown error" }, :status => 500
		end
	end

	def show
		render :json => { :profile => Profile.find(params[:id]) }
	end

	def create
	  @profile = Profile.new(permitted_params[:profile])
	  if @profile.user = User.find_by_uid(params[:uid]) and @profile.save
	    render :json => { :profile => @profile }
	  else
	    render :json => {errors: @profile.errors, message: "The record was not saved due to errors"}, status: 500
	  end
	end

	def update
	  @profile = Profile.find(params[:id])
	  if @profile.update(permitted_params[:profile])
	  	render :json => { :profile => @profile }
	  else
	    render json: @profile.errors, status: :unprocessable_entity
	  end
	end

	def destroy
	  @profile = Profile.find(params[:id])
	  @profile.destroy
	  head :no_content
	end


	private
		def permitted_params
	    params.permit(
	      :profile => [
	        :entity_type_id,
	        :num_employees,
	        :annual_revenue,
	        :annual_sales,
	        :org_type,
	        :company_name,
	        :address1,
	        :address2,
	        :city,
	        :state,
	        :postal_code,
	        :currently_exporting,
	        :naics_sector,
	        :naics_code,
	        :duns_no,
	        :biz_usa_store,
	        :export_type,
	        :people_attributes => [
	          :id,
	          :first_name,
	          :last_name,
	          :email,
	          :title,
	          :_destroy
	        ],
	      ],
	    )
	end
end
