class IncognitoUser < ActiveRecord::Base
  attr_accessible :grupa_nume, :token
  belongs_to :grupa
  has_one :sesiune_activa
  has_many :evaluare_completate
end
