class HomeController < ApplicationController
    def index
      @categories = Category.limit(4) # Adjust as needed
      @new_arrivals = Product.new_arrivals.limit(4) # Using the scope we defined earlier
    end
  end