class SbirAppsController < ApplicationController
  def show
    @form = MYUSA_FORMS['SF-424']
  end
end
