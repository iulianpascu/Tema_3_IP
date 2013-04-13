class RemoveContinutFromEvaluareCompletata < ActiveRecord::Migration
  def up
    remove_column :evaluare_completate, :continut
  end

  def down
    add_column :evaluare_completate, :continut, :string
  end
end
