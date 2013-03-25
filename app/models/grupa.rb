class Grupa < ActiveRecord::Base
  attr_accessible :grupa, :studenti
	
  has_many :users
  has_many :evaluares
  
end
