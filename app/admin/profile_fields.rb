ActiveAdmin.register ProfileField do
  controller do
    def permitted_params
      params.permit(:profile_field => [:name, :field_type, :required])
    end
  end
end

