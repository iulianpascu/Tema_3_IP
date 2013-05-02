class AddDetaliiToEvaluari < ActiveRecord::Migration
  def change
    add_column :evaluare_disponibile, :semestru, :integer
    add_column :evaluare_completate, :data, :date
  end
end
