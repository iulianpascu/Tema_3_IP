class Formular < ActiveRecord::Base
  attr_accessible :continut
  serialize :continut, ActiveRecord::Coders::Hstore
  has_many :evaluare_disponibile
end
