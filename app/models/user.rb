class User < ActiveRecord::Base
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	before_create { generate_token(:auth_token) }

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

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
