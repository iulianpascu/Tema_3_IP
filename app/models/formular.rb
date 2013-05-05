class Formular < ActiveRecord::Base
  attr_accessible :continut
  has_many :grupe
end
