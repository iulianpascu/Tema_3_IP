class Profesor < ActiveRecord::Base
  attr_accessible :id_prof, :nume_prof

   has_many :evaluares
   has_many :evaluare_finalizata
end
