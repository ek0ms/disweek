class LocationsController < ApplicationController
  def index
    binding.pry
  end

  def create
    @location = Location.new
  end

end
