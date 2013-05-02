class Grupa < ActiveRecord::Base
  attr_accessible :nume, :studenti, :terminal
  has_one :data_evaluare
  has_many :incognito_users
  has_many :eval_disponibile
  has_many :cursuri, :through => :eval_disponibile

end
