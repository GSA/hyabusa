class SbirAppsController < ApplicationController
  def new
    @form = MYUSA_FORMS['SF-424']
    gon.myusa_form_tooltips = @form['form_fields'].map{|x| x['name']}
  end
end
