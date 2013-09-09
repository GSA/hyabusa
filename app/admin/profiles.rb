ActiveAdmin.register Profile do
  controller do
    def permitted_params
      params.permit(:profile => [:user_id, :profile_section_id, :properties])
    end
  end
end
