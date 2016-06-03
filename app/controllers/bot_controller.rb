class BotController < ApplicationController

	def webhook
	   if params[‘hub.verify_token’] == 'supoTai@2014'
     		render text: params[‘hub.challenge’] and return
   		else
     		render text: ‘error’ and return
   		end
	end

end