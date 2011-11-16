class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # before_filter :delay
  
  protected  
    def delay
      # Simulate slow server 
      sleep 1
    end
end
