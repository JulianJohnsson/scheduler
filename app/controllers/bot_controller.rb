class BotController < ApplicationController

	def webhook
	   if params[‘hub.verify_token’] == 'supoTai@2014'
     		render text: params[‘hub.challenge’] and return
   		else
     		render text: ‘error’ and return
   		end
	end

	def receive_message
		if params[:entry]
			messaging_events = params[0][:messaging]
			messaging_events.each do |events|
				sender = event[:sender][:id]
				if (text = event[:message] && event[:message][:text])
					send_text_message(sender, "Hi there! You said: #{text}.")
				end
			end
		end
		render nothing: true
	end
end