class DataEvaluare < ActiveRecord::Base
  attr_accessible :data, :grupa_terminal
  belongs_to :grupa
end
