class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end


  def show
    @user = User.find(params[:id])
  end

  # workaround for CanCan and strong params in Rails 4 (https://github.com/ryanb/cancan/issues/835)
  def user_params
    params.require(:user).permit(:role, :email, :name)
  end
end
