
include Facebook::Messenger

Bot.on :message do |message|

	puts "Received #{message.text} from #{message.sender}"

  	case message.text
  	
  	when (/hello/i || /coucou/i || /salut/i || /bonjour/i || /yo/i)
	  	Bot.deliver(
	    	recipient: message.sender,
	    	message: {
	      		text: "Bonjour Humain ! Je suis le scheduler bot de JulianJohnsson :-)"
	    	}
	  	)

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
	              { type: 'postback', title: 'Dans 1h', payload: '1' }
	              { type: 'postback', title: 'Autre', payload: 'OTHER' }
	            ]
	          }
	        }
	    }
    )

	else
		Bot.deliver(
	    	recipient: message.sender,
	    	message: {
	      		text: "Je ne vous parlerais pas si vous ne me dites pas bonjour !"
	    	}
	  	)
	  	Bot.deliver(
	    	recipient: message.sender,
	    	message: {
	      		text: "Bisous"
	    	}
	  	)
		
end

Bot.on :postback do |postback|
	case postback.payload
	when 'NOW'
		text = 'That makes bot happy!'
	when '1'
	    text = 'Oh.'
	when 'OTHER'
		text = 'youhou'
  end

  Bot.deliver(
    recipient: postback.sender,
    message: {
      text: text
    }
  )
end