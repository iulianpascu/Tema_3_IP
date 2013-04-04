class RemoveAnFromCurs < ActiveRecord::Migration
  def up
    remove_column :cursuri, :an
  end

  def down
    add_column :cursuri, :an, :integer
  end
end
