ActiveAdmin.register ProfileSection do
  form do |f|
    f.inputs "ProfileSection" do
      f.input :name
    end
    f.actions

    f.inputs "Fields", html: { class: 'horizontal-form' } do
      f.has_many :fields do |field_f|
        field_f.input :id, as: :hidden
        field_f.input :name, input_html: { size: 20 }
        field_f.input :field_type, as: :select, collection: ProfileField::FIELD_TYPES
        field_f.input :required
      end
    end
    f.actions
  end

  show do |section|
    attributes_table do
      row :name
      row :created_at
      row :updated_at
      row :fields do |section|
        section.fields.map{|f| "#{f.name.capitalize()} (#{f.field_type})"}.join(', ').html_safe
      end
    end
  end

  controller do
    def permitted_params
      params.permit(:profile_section => [:id, :name, :fields_attributes => [:id, :name, :field_type, :required]])
    end
  end
end
