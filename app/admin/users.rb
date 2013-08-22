ActiveAdmin.register User do
  controller do
    def permitted_params
      params.permit(:user => [:name, :email])
    end
  end
end
