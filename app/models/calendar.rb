class Calendar < ActiveRecord::Base
	belongs_to :user

	def get_calendar_list(user)
		client = Signet::OAuth2::Client.new(access_token: user.access_token)
  	service = Google::Apis::CalendarV3::CalendarService.new
  	service.authorization = client
  	calendar_list = service.list_calendar_lists

  	calendars = Hash[calendar_list.items.map{|calendar| [calendar.summary, calendar.id]}]
  end

  def fetch_calendar(options={})
    defaults = {
      :datemin => DateTime.now,
      :datemax => nil
    }
    options = defaults.merge(options)

  	client = Signet::OAuth2::Client.new(access_token: self.user.access_token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    if options[:datemax] != nil
      event_list = service.list_events(self.google_calendar_id, 
        time_min: options[:datemin].to_datetime.rfc3339, 
        time_max: options[:datemax].to_datetime.rfc3339
        ).items
    else
      event_list = service.list_events(self.google_calendar_id, 
        time_min: options[:datemin].to_datetime.rfc3339
        ).items
    end
  end

  def is_busy?(datemin, datemax)
    options = { :datemin => datemin, :datemax => datemax }
    event_list = fetch_calendar(options)
    
    if event_list.empty?
      return false
    else
      return true
    end  
  end

end
