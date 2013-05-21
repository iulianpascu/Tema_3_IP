class AddSemToEvalCompletata < ActiveRecord::Migration
  def change
    add_column :eval_completate, :semestru, :integer
    add_column :eval_completate, :an, :integer
  end
end
