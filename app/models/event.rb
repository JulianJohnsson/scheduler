class Event < ActiveRecord::Base
	def finished?
		finish_at < Time.now
	end
end
