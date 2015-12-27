class Event < ActiveRecord::Base
	
	scope :finished, -> { where('finish_at <= ?', DateTime.now) } 
	scope :search, -> (keyword) { where(title: keyword) if keyword.present? }

	def finished?
		finish_at < Time.now
	end
end
