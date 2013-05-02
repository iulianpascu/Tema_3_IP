class RenameEvaluareDisponibilaToEvalDisponibila < ActiveRecord::Migration
  def up
    rename_table :evaluare_disponibile, :eval_disponibile
  end

  def down
    rename_table :eval_disponibile, :evaluare_disponibile
  end
end
