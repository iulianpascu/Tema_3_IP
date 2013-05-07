class AddFormularToAsociere < ActiveRecord::Migration
  def up
    add_column :asocieri, :formular_id, :integer
    remove_column :grupe, :formular_id
  end

  def down
    add_column :grupe, :formular_id, :integer
    remove_column :asocieri, :formular_id
  end
end
