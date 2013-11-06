class ProfilesController < ApplicationController
  include ApplicationHelper

  before_filter :authenticate_user!

  def show
    unless @profile = current_user.profile
      redirect_to new_profile_path, notice: 'Create a profile to get started!' and return
    end

    respond_to do |format|
      format.html
      format.xml  { render xml: @profile, include: :people, exclude: :biz_usa_store }
      format.json { render json: @profile, include: :people, exclude: :biz_usa_store }
    end
  end

  def new
    if current_user.profile
      redirect_to edit_profile_path and return
    else
      @profile = Profile.new(permitted_params || {})
      gon.naics_codes = formatted_naics
    end
  end

  def create
    @profile = Profile.new(permitted_params[:profile])
    @profile.user = current_user

    if @profile.save
      redirect_to profile_path, notice: 'Profile was successfully created.'
    else
      render action: :new
    end
  end

  def edit
    unless current_user.profile
      redirect_to new_profile_path, notice: 'Create a profile to get started!' and return
    else
      @profile = current_user.profile
      gon.naics_codes = formatted_naics
    end
  end

  def update
    @profile = current_user.profile

    if @profile.update_attributes!(permitted_params[:profile])
      flash[:notice] = 'Your profile was successfully updated.'
      redirect_to profile_path, notice: 'Your profile was successfully updated.'
    else
      render action: :edit
    end
  end

  def destroy
    current_user.profile.destroy
  end

  private

  def formatted_naics
    NAICS_CODES.map{|x| {name: x['title'], tokens: x['title'].split(/[ \-,.]/), value: x['code']}}
  end

  def permitted_params
    params.permit(
      :profile => [
        :profile_id,
        :entity_type_id,
        :num_employees,
        :annual_export_sales,
        :org_type,
        :company_name,
        :address1,
        :address2,
        :city,
        :state,
        :postal_code,
        :country,
        :currently_exporting,
        :naics_sector,
        :naics_code,
        :phone_number,
        :fax_number,
        :dunn_bradstreet,
        :website_url,
        :percent_export_sales,
        :export_status,
        :auth_export_gov_to_share,
        :auth_trade_promo_contact,
        :responsible_person_intl,
        :documented_product_sales_dist_auth,
        :biz_usa_store,
        :export_type,
        :people_attributes => [
          :id,
          :first_name,
          :last_name,
          :email,
          :title,
          :phone_work,
          :phone_mobile,
          :_destroy
        ],
      ],
    )
  end
end
