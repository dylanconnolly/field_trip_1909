require 'rails_helper'

RSpec.describe "passenger show page" do
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

  it "displays that passenger's name and has a section of the page that lists all of that passenger's flight numbers which link to flight show page" do

    visit passenger_path(@bob)

    expect(page).to have_content(@bob.name)

    within "#flights" do
      expect(page).to have_link(@southwest_1.number)
      click_link(@southwest_2.number)
    end

    expect(current_path).to eq(flight_path(@southwest_2))
  end
end
