module ApplicationHelper
  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)

    if ENV['RAILS_ENV'] == 'production'
      default = "#{root_url}assets/guest.png"
      default = CGI.escape(default)
    else
      default = 'blank'
    end

    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{default}"
  end
end
