class Curs < ActiveRecord::Base
  attr_accessible :nume, :profesor_id, :tip, :an, :specializare
  belongs_to :profesor
  has_many :eval_disponibile
  has_many :grupe, :through => :eval_disponibile
end
