class Curs < ActiveRecord::Base
  attr_accessible :id_curs, :nume_curs, :tip_curs

  has_many :evaluares
  has_many :evaluare_finalizata
end
