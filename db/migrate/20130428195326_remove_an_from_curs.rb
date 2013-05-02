class RemoveAnFromCurs < ActiveRecord::Migration
  def up
    remove_column :cursuri, :an
  end

  def down
    add_column :cursuri, :an, :string
  end
end
