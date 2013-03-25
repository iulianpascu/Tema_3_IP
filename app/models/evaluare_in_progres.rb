class EvaluareInProgres < ActiveRecord::Base
  attr_accessible :incepere_sesiune, :token

  belongs_to :users
  has_many :evaluare_finalizata
end
