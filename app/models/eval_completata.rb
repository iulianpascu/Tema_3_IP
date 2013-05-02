class EvalCompletata < ActiveRecord::Base
  attr_accessible :continut, :eval_disponibila_id, :incognito_user_token, :timp, :data
  serialize :continut, ActiveRecord::Coders::Hstore
  belongs_to :incognito_user
  belongs_to :eval_disponibila
end
