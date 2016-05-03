class CalendarsController < ApplicationController

	def new
		@calendar = Calendar.new
		@calendars = @calendar.get_calendar_list(current_user)
	end

	def create
		@calendar = Calendar.new(calendar_params)

	    if @calendar.save
	    	redirect_to @calendar, notice: "L'agenda est en cours de synchronisation"
	    else
	    	render :new 
	    end
	end

	def show
		@calendar = Calendar.find(params[:id])
		@events_list = @calendar.fetch_calendar

		unless @calendar.user == current_user
      		redirect_to root_path, :alert => "Access denied."
    	end
	end

	private

	def calendar_params
		params.require(:calendar).permit(:name, :google_calendar_id, :user_id)
	end

end
