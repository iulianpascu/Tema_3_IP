class Curs < ActiveRecord::Base
  attr_accessible :nume, :profesor_id, :tip
  belongs_to :profesor
  has_many :evaluare_disponibile
  has_many :grupe, :through => :evaluare_disponibile
end