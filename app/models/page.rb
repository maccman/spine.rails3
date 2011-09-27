class Page < ActiveRecord::Base
  validates_presence_of :name
  
  attr_accessor :session_id
end