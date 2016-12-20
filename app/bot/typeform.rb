class MyNewTypeform

  include AskAwesomely::DSL

  title "My New Typeform"

  tags "awesome", "hehe"

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

    ref :1
  end

  jump from: :1, to: :2, if: false

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

    ref :2
  end

  design do
    question_color "#FF0099"
    button_color "#ABCDEF"
    answer_color "#4AF6E9"
    background_color "#000000"

    font "Vollkorn"
  end

end

