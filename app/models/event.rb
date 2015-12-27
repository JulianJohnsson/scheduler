class Event < ActiveRecord::Base
	
scope :finished, -> { where('finish_at <= ?', DateTime.now) }

	def finished?
		finish_at < Time.now
	end
end
