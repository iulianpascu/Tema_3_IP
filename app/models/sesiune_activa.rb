class SesiuneActiva < ActiveRecord::Base
  attr_accessible :incepere_data, :incognito_user_token
  belongs_to :incognito_user
  

end
