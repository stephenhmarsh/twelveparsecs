# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

parsec1 = Parsec.create(title: "test", body: "kekekeke, keke. Keke. lol.", media_id: 1, user_id: 1, score: 5, time: Time.now)