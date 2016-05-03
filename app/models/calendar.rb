class Calendar < ActiveRecord::Base
	belongs_to :user

	def get_calendar_list(user)
		client = Signet::OAuth2::Client.new(access_token: user.access_token)
  		service = Google::Apis::CalendarV3::CalendarService.new
  		service.authorization = client
  		calendar_list = service.list_calendar_lists

  		calendars = Hash[calendar_list.items.map{|calendar| [calendar.summary, calendar.id]}]
    end

    def fetch_calendar
		client = Signet::OAuth2::Client.new(access_token: self.user.access_token)
  		service = Google::Apis::CalendarV3::CalendarService.new
  		service.authorization = client
  		event_list = service.list_events(self.google_calendar_id, time_min: DateTime.now.to_datetime.rfc3339).items
   	end

end
