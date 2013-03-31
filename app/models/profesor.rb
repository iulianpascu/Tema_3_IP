class Profesor < ActiveRecord::Base
  attr_accessible :nume, :prenume
  has_many :cursuri
end
