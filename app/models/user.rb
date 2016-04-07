class User < ActiveRecord::Base
	has_secure_password

	class << self
	  def from_omniauth(auth_hash)
	    user = User.find_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
	    if user == nil
			user = User.create(uid: auth_hash['uid'], provider: auth_hash['provider'], password: auth_hash['uid'], password_confirmation: auth_hash['uid'], location: auth_hash['info']['location'], image_url: auth_hash['info']['image'], name: auth_hash['info']['name'], email: auth_hash['info']['email'])
		end
		user
	  end
	end
end
