class EvaluareCompletata < ActiveRecord::Base
  attr_accessible :continut, :evaluare_disponibila_id, :incognito_user_token, :timp
  serialize :continut, ActiveRecord::Coders::Hstore
  belongs_to :incognito_user
  belongs_to :evaluare_disponibila
end
