class AddHstoreToEvaluareCompletata < ActiveRecord::Migration
  def change
    add_column :evaluare_completate, :continut, :hstore
  end
end
