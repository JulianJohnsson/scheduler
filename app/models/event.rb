class Event < ActiveRecord::Base
	
	scope :finished, -> { where('finish_at <= ?', DateTime.now) } 
	scope :search, -> (keyword) { where('keywords LIKE ?', "%#{keyword.downcase}%") if keyword.present? }

	before_save :set_keywords

	def finished?
		if finish_at.present?
			finish_at < Time.now
		else
			false
		end
	end

		def set_keywords
			self.keywords = [title, author, description].map(&:downcase).join(' ')
		end
end
