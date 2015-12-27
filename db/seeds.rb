# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.destroy_all

events = Event.create!([{
		title: "Déjeuner d'affaire",
		author: "Julien Janson",
		description: "Il s'agit d'un business lunch de la plus haute importance.",
		duration: 2
	},
	{
		title: "Apéro",
		author: "Vincent Lorber",
		description: "Venez boire l'apéro à la maison et découvrir mon nouveau chez moi !",
		duration: 4
	}])