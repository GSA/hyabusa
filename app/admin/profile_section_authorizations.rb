ActiveAdmin.register ProfileSectionAuthorization do
  controller do
    def permitted_params
      params.permit(:profile_section_authorization => [:id, :profile_section_id, :is_admin_approved, :is_pra_pending, :is_pra_approved, :omb_control_no, :pra_approved_on])
    end
  end
end
