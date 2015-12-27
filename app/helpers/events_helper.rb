module EventsHelper

	def image_from_amazon(image_id)
		image_tag "http://images.amazon.com/images/P/#{image_id}.01.ZTZZZZZZ.jpg"
	end
end
