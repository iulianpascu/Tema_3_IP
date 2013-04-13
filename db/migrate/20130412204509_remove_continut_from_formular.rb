class RemoveContinutFromFormular < ActiveRecord::Migration
  def up
    remove_column :formulare, :continut
  end

  def down
    add_column :formulare, :continut, :string
  end
end
