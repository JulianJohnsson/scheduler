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

  def isbusy(datemin, datemax)
    client = Signet::OAuth2::Client.new(access_token: self.user.access_token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    items = Google::Apis::CalendarV3::FreeBusyRequestItem.new
    items.id = self.google_calendar_id

    free_busy = Google::Apis::CalendarV3::FreeBusyRequest.new
    free_busy.items = items
    free_busy.time_min = datemin.to_datetime.rfc3339
    free_busy.time_max= datemax.to_datetime.rfc3339

    is_busy = service.query_freebusy([free_busy]).calendars.busy
    
    if is_busy.empty?
      return false
    else
      return true
    end     
  end
end
