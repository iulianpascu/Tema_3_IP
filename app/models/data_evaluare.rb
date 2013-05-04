class DataEvaluare < ActiveRecord::Base
  attr_accessible :data, :grupa_terminal
  has_many :grupe, { :primary_key => 'grupa_terminal', 
                     :foreign_key => 'terminal'}
end
