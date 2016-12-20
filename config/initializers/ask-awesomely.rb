require "ask_awesomely"

AskAwesomely.configure do |config|
  #config.typeform_api_key = ENV["YOUR_TYPEFORM_IO_API_KEY"]
  config.typeform_api_key = "d99df46551e8264ebbf4fbf9c7779368"
end

class MyNewTypeform

  include AskAwesomely::DSL

 # title "Créer"

  #tags "awesome", "hehe"

  field :statement do
    say ->(user) { "Hello, #{user.name}!" }
  end

  field :multiple_choice do
    ask "What is your favourite language?"
    choice "Ruby"
    choice "Python"
    choice "Javascript"
    choice "COBOL"

    can_specify_other
  end

  field :yes_no do
    ask "Avez-vous déjà choisi le nom de votre société ?"
    required

    ref :q1
  end

  jump from: :q1, to: :q2, if: false

  field :short_text do
    ask "Quel sera le nom de votre société ?"
    max_characters 50
  end

  field :multiple_choice do
    ask "Quelle forme juridique souhaitée vous donner à votre entreprise ?"
    choice "SASU"
    choice "EURL"
    choice "SAS"
    choice "SARL"
    required

    ref :q2
  end

  design do
    question_color "#3B3F3F"
    button_color "#E32636"
    answer_color "#EC8F97"
    background_color "#FFFFFF"

    font "Vollkorn"
  end

end

