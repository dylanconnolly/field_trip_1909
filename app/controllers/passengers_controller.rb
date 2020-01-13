class PassengersController < ApplicationController

  def show
    @passenger = Passenger.find(params[:id])
  end

  def update
    passenger = Passenger.find(params[:id])
    passenger.flights << Flight.where(number: params[:flight_number])
    redirect_to passenger_path(passenger)
  end
end
