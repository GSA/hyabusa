class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  # workaround for CanCan and strong params in Rails 4 (https://github.com/ryanb/cancan/issues/835)
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def current_admin_user
      if current_user && (@current_user.has_role?(:super_admin) || @current_user.has_role?(:agency_admin))
        current_user
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def authenticate_admin_user!
      if current_user
        if ! [:super_admin, :agency_admin].any? {|role| current_user.has_role?(role)}
          redirect_to root_url, :alert => 'You are not authorized to access this page.'
        end
      else
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

end
