class ProfilesController < ApplicationController

  def show
    @profile = Profile.find_by_user_id(current_user.id)

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
    unless @profile = Profile.find_by_user_id(current_user.id)
      redirect_to new_profile_path, notice: 'You must create a new profile.'
    end
  end

  def create
    @profile = Profile.new(permitted_params[:profile])
    @profile.user(current_user)

    if @profile.save
      redirect_to @profile, notice: 'Profile was successfully created.'
    else
      render action: :new
    end
  end

  def update
    @profile = Profile.find_by_user_id(current_user.id)

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
    params.permit(:profile => [:id, :profile_section_id]).permit(:properties => [ "Company Name" ])
  end
end
