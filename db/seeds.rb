# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.destroy_all
Tag.destroy_all

repas = Tag.create!(name: 'repas')
apero = Tag.create!(name: 'apéro')

events = Event.create!([{
		title: "Déjeuner d'affaire",
		author: "Julien Janson",
		description: "Il s'agit d'un business lunch de la plus haute importance.",
		duration: 2,
		tags: [repas],
		start_at: '',
		finish_at: '2015-12-14'
	},
	{
		title: "Apéro",
		author: "Vincent Lorber",
		description: "Venez boire l'apéro à la maison et découvrir mon nouveau chez moi !",
		duration: 4,
		tags: [apero],
		start_at: '',
		finish_at: '2015-12-30'
	},
	{
		title: "Teuf du vendredi 13",
		author: "Julien Janson",
		description: "Venez la grosse teuf à la case pour décompresser de cette rude semaine.",
		duration: 4,
		tags: [apero, repas],
		start_at: '',
		finish_at: '2015-12-31'
	}])