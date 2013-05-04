class IncognitoUser < ActiveRecord::Base
  attr_accessible :grupa_nume, :token
  belongs_to :grupa, { :primary_key => 'nume', 
                       :foreign_key => 'grupa_nume', 
                       :inverse_of => :incognito_users }
  has_one :sesiune_activa
  has_many :eval_completate
end
