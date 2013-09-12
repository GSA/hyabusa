ActiveAdmin.register User do
  index do
    actions
    column :name
    column :email
    #column :provider
    column :agency
    column :roles, sortable: 'roles.name' do |user|
      user.roles.map{|r| link_to r.name.capitalize(), admin_role_path(r)}.join(', ').html_safe
    end
    column :created_at
    column :updated_at
  end

  form do |f|
    f.inputs "User" do
      f.input :name
      f.input :email
      f.input :agency, as: :select, collection: AGENCIES
    end
    f.inputs "Roles" do
      f.input :roles, :as => :check_boxes
    end
    f.actions
  end

  show do |user|
    h3 user.name
    attributes_table do
      row :id
      row :uid
      row :email
      row :agency
      row :created_at
      row :updated_at
      row :roles do |user|
        user.roles.map{|r| r.name.capitalize()}.join(', ').html_safe
      end
    end
  end

  controller do
    def permitted_params
      params.permit(:user => [:id, :name, :email, :agency, :roles])
    end

    def scoped_collection
      resource_class.includes(:roles)
    end

    def update
      user = User.find(params[:id])

      # update roles to match checkboxes
      role_ids = params[:user][:role_ids]
      user.roles.clear()
      user.roles << role_ids.select{|id| !id.empty? }.map{|id| Role.find(id)}

      super
    end
  end
end
