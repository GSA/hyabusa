class User < ActiveRecord::Base
  rolify

  validates_presence_of :name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.email = auth['info']['email'] || ""
         user.name = auth['info']['name'] || user.email
      end
    end
  end
end