Rails.application.config.middleware.use OmniAuth::Builder do
  provider :myusa, ENV['MYUSA_OAUTH_PROVIDER_KEY'], ENV['MYUSA_OAUTH_PROVIDER_SECRET'],
	  :client_options => {
	  		:site => ENV['MYUSA_HOME'],
	  		:token_url => "/oauth/authorize",
	  		:ssl => {
	  			# :verify => (ENV['RAILS_ENV'] == 'development') ? false : true
	  			:verify => false
	  		}
	  	},
	  :scope => ENV['MYUSA_SCOPES']
end

OmniAuth.config.on_failure = SessionsController.action(:failure)