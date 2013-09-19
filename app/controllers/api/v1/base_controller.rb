class Api::V1::BaseController < ApplicationController
	def index
		render :json => {
			:meta => {
				:description => "Welcome to the first version of the My BusinessUSA API endpoint built on top of MyUSA. For more information, visit http://my.usa.gov.",
				:endpoints => [
					{
						:name => "Profiles",
						:url => "/api/profiles",
						:description => "Returns business profiles based on ID or searches based on MyUSA ID. Accepts updates to business profiles from users and applications with write access."
					}
				]
			}
		}
	end
end
