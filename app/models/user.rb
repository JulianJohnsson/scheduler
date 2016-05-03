class User < ActiveRecord::Base
	has_secure_password
	has_many :calendars
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	before_create { generate_token(:auth_token) }

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	class << self
	  def from_omniauth(auth_hash)
	    user = User.find_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
	    if user == nil
	    	user = User.find_by_email(auth_hash['info']['email'])
	    	if user == nil
				user = User.create(uid: auth_hash['uid'], provider: auth_hash['provider'], password: auth_hash['uid'], password_confirmation: auth_hash['uid'], location: auth_hash['info']['location'], image_url: auth_hash['info']['image'], name: auth_hash['info']['name'], email: auth_hash['info']['email'])
			else
				user.uid = auth_hash['uid']
				user.provider = auth_hash['provider'] 
				user.location = auth_hash['info']['location'] 
				user.image_url = auth_hash['info']['image']
				user.save!
			end
		end
		user.access_token = auth_hash['credentials']['token']
		user.refresh_token = auth_hash['credentials']['refresh_token']
		user.save!
		user
	  end
	end
end
