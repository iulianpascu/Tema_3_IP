class RenameEvaluareCompletataToEvalCompletata < ActiveRecord::Migration
  def up
    rename_column :evaluare_completate, :evaluare_disponibila_id, :eval_disponibila_id
    rename_table :evaluare_completate, :eval_completate
  end

  def down
    rename_column :eval_completate, :eval_disponibila_id, :evaluare_disponibila_id
    rename_table :eval_completate, :evaluare_completate
  end
end
