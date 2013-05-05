class ClearFieldsCurs < ActiveRecord::Migration
  def up
    remove_column :cursuri, :grupa_id
    remove_column :cursuri, :semestru
    remove_column :cursuri, :an_universitar
    remove_column :cursuri, :formular_id
  end

  def down
    add_column :cursuri, :grupa_id, :integer
    add_column :cursuri, :semestru, :integer
    add_column :cursuri, :an_universitar, :integer
    add_column :cursuri, :formular_id, :integer
  end
end
