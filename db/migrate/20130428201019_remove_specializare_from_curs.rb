class RemoveSpecializareFromCurs < ActiveRecord::Migration
  def up
    remove_column :cursuri, :specializare
  end

  def down
    add_column :cursuri, :specializare, :string
  end
end
