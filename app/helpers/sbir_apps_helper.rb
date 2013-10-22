module SbirAppsHelper
  def form_title(form)
    "#{form['title']} (#{form['number']})"
  end

  def form_input(f, form_field)
    f.input form_field['name'],
      as: formtastic_field_type(form_field),
      collection: form_field['options'],
      hint: form_field['description'],
      title: form_field['label'],
      label: form_field['label'] || form_field['name'].humanize,
      required: form_field['is_required']
  end

  def omb_info(form)
    link_to "Form Approved OMB##{form['omb_control_number']} | Expires at #{form['omb_expiration_date']}", "http://www.reginfo.gov/public/do/PRAViewICR?ref_nbr=#{form['icr_reference_number']}"
  end

  def formtastic_field_type(field)
    case field['field_type']
    when "date"
      "date_select"
    when "datetime"
      "datetime_select"
    else
      field['field_type']
    end
  end
end
