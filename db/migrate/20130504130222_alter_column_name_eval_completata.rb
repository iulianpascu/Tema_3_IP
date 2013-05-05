class AlterColumnNameEvalCompletata < ActiveRecord::Migration
  def up
    rename_column :eval_completate, :eval_disponibila_id, :curs_id
  end

  def down
    rename_column :eval_completate, :curs_id, :eval_disponibila_id
  end
end
