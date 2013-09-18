class ProfilesController < ApplicationController

  def show
    @profile = current_user.profile

    unless @profile
      redirect_to new_profile_path
    end
  end

  def new
    if current_user.profile
      redirect_to edit_profile_path
    else
      @profile = Profile.new(permitted_params || {})
      @profile.profile_section_id ||= 1
    end
  end

  def edit
    unless @profile = Profile.where(user: current_user).first
      redirect_to new_profile_path, notice: 'You must create a new profile.'
    end
  end

  def create
    #binding.pry
    @profile = Profile.new(permitted_params[:profile])
    @profile.update_properties(permitted_params[:properties])
    @profile.user = current_user

    if @profile.save
      redirect_to @profile, notice: 'Profile was successfully created.'
    else
      render action: :new
    end
  end

  def update
    @profile = current_user.profile

    @profile.update_properties(permitted_params[:properties])
    if @profile.update_attributes!(permitted_params[:profile])
      flash[:notice] = 'Your profile was successfully updated.'
      redirect_to @profile, notice: 'Your profile was successfully updated.'
    else
      render action: :edit
    end
  end

  def destroy
    current_user.profile.destroy
  end

  private

  def permitted_params
    params.permit(profile: [:profile_section_id], properties: [:company_name, :address1, :address2, :city, :state, :zip_code])
  end
end
