# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
southwest = Airline.create(name: "Southwest Airlines")
american = Airline.create(name: "American Airlines")

southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
bob = southwest_1.passengers.create!(name: "Bob", age: 42)
sherry = southwest_1.passengers.create!(name: "Sherry", age: 24)
junior = southwest_1.passengers.create!(name: "Junior", age: 13)

southwest_2 = southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")
dalvin = southwest_2.passengers.create!(name: "Dalvin", age: 32)
southwest_2.passengers << bob

american_1 = american.flights.create(number: "AA1", date: "01/18/20", time: "0945", departure_city: "San Francisco", arrival_city: "Denver")
carl = american_1.passengers.create!(name: "Carl", age: 65)
darcy = american_1.passengers.create!(name: "Darcy", age: 42)
