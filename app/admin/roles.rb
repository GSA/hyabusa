ActiveAdmin.register Role do
  controller do
    def permitted_params
      params.permit(:role => [:name, :resource_type, :resource_id])
    end
  end
end
