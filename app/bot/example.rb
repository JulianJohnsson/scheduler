
include Facebook::Messenger

@user = User.find_by_email('juljanson@gmail.com')

Bot.on :optin do |optin|
	customer = Conversation.find_by_facebook_id(optin.sender)
	if customer
		#greetings(optin)
	else
		#greetings_stranger(optin)
	end
end

Bot.on :message do |message|

	puts "Received #{message.text} from #{message.sender}"
	customer = Conversation.find_by_facebook_id(message.sender)
	case message.text
	when /dispo/i
		Bot.deliver(
	      recipient: message.sender,
	      message: {
	        attachment: {
	          type: 'template',
	          payload: {
	            template_type: 'button',
	            text: 'Quand?',
	            buttons: [
	              { type: 'postback', title: 'Now', payload: 'NOW' },
	              { type: 'postback', title: 'Dans 1h', payload: '1' },
	              { type: 'postback', title: 'Autre', payload: 'OTHER' }]
	          	}
	        	}
	    	}
    	)
	else
		if customer
			if customer.is_occuring_conversation? # TO DO
				if customer.isquestion
					case customer.question
					when 'name'
						#confirm_name(message)
					# handle other contextual message
					end
				else
					# if no further clue, keep going conversation, drive to dispo command
				end
			else
				# si pas fait d'optin greetings, sinon follow up de greetings
			end
		elsif message.text =~ /bonjour/i
			Bot.deliver(
		    	recipient: message.sender,
		    	message: {
		      		text: "Bonjour Humain ! Je suis le scheduler bot de JulianJohnsson :-)"
		    	}
		  	)
		  	#ajouter que je gère la dispo, mais que pour commencer je veux ton nom pour me souvenir de toi
		  	#sleep(2)
		  	customer = Conversation.create(facebook_id: "#{message.sender}")
		  	customer.isquestion = true
		  	customer.question = 'name'
		  	customer.save!

		  	Bot.deliver(
		    	recipient: message.sender,
		    	message: {
		      		text: "Comment tu t'appelles ?"
		    	}
		  	)
		else
			Bot.deliver(
		    	recipient: message.sender,
		    	message: {
		      		text: "Je ne vous parlerais pas si vous ne me dites pas bonjour !"
		    	}
		  	)
		  	sleep(2)
		  	Bot.deliver(
		    	recipient: message.sender,
		    	message: {
		      		text: "Bisous"
		    	}
		  	)
		end
	end		
end

Bot.on :postback do |postback|
	case postback.payload
	when 'NOW'
		# contacter calendar api isbusy?
		if @user.calendars.first.is_busy?(DateTime.now, 2.hours.from_now)
			text = 'Occupé !'
		else 
			text = 'Libre !'
		end
	when '1'
	    text = 'Oh.'
	when 'OTHER'
		text = 'youhou'
	#when save name
  	end

  Bot.deliver(
    recipient: postback.sender,
    message: {
      text: text
    }
  )
end