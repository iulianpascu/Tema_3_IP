class Grupa < ActiveRecord::Base
  attr_accessible :nume, :studenti, :terminal
  has_one :data_evaluare
  has_many :incognito_users
  has_many :evaluare_disponibile
end
