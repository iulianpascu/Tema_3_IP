class AddColumnsToCurs < ActiveRecord::Migration
  def change
    add_column :cursuri, :formular_id, :integer
    add_column :cursuri, :grupa_id, :integer
    add_column :cursuri, :semestru, :integer
  end
end
