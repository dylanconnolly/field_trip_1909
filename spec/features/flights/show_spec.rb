require 'rails_helper'

RSpec.describe "flight show page" do
  before :each do
    @southwest = Airline.create(name: "Southwest Airlines")
    @american = Airline.create(name: "American Airlines")

    @southwest_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
    @bob = @southwest_1.passengers.create!(name: "Bob", age: 42)
    @sherry = @southwest_1.passengers.create!(name: "Sherry", age: 24)
    @junior = @southwest_1.passengers.create!(name: "Junior", age: 13)

    @southwest_2 = @southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")
    @dalvin = @southwest_2.passengers.create!(name: "Dalvin", age: 32)
    @southwest_2.passengers << @bob

    @american_1 = @american.flights.create(number: "AA1", date: "01/18/20", time: "0945", departure_city: "San Francisco", arrival_city: "Denver")
    @carl = @american_1.passengers.create!(name: "Carl", age: 65)
    @darcy = @american_1.passengers.create!(name: "Darcy", age: 42)
  end

  it "lists all of the flight's info as well as the airline name and a list of passengers" do

    visit "/flights/#{@southwest_1.id}"

    expect(page).to have_content(@southwest_1.number)
    expect(page).to have_content(@southwest_1.date)
    expect(page).to have_content(@southwest_1.departure_city)
    expect(page).to have_content(@southwest_1.arrival_city)
    expect(page).to have_content(@southwest.name)
    expect(page).to have_content(@bob.name)
    expect(page).to have_content(@sherry.name)
    expect(page).to have_content(@junior.name)

    expect(page).to_not have_content(@southwest_2.number)
    expect(page).to_not have_content(@american_1.number)
    expect(page).to_not have_content(@dalvin.name)
    expect(page).to_not have_content(@carl.name)
  end
end
