class IndexToEvaluareCompletataContinut < ActiveRecord::Migration
  def up
    execute 'CREATE INDEX eval_comp_continut ON evaluare_completate USING GIN(continut)'
  end

  def down
    execute 'DROP INDEX eval_comp_continut'
  end
end
