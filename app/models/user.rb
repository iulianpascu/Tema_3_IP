class User < ActiveRecord::Base
  attr_accessible :grupa, :token

   before_save :create_cookie

   belongs_to :grupas
   
   has_one :evaluare_in_progres

   validates :token, :presence => true, length: {maximum: 10}

  private
    def create_cookie
      self.cookie = SecureRandom.urlsafe_base64
    end
end