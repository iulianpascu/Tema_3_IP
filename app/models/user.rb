class User < ActiveRecord::Base
  attr_accessible :grupa, :token

   belongs_to :grupa
end
