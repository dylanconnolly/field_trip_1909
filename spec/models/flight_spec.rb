require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'validations' do
    it {should validate_presence_of :number}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
    it {should validate_presence_of :departure_city}
    it {should validate_presence_of :arrival_city}
  end
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :flight_passengers}
    it {should have_many(:passengers).through(:flight_passengers)}
  end

  describe "instance methods" do
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
      @american_1.passengers << @dalvin
    end

    it "#minors" do
      expect(@southwest_1.minors).to eq(1)

      expect(@southwest_2.minors).to eq(0)
    end

    it "#adults" do
      expect(@southwest_1.adults).to eq(2)
      expect(@southwest_2.adults).to eq(2)
      expect(@american_1.adults).to eq(3)
    end
  end
end
