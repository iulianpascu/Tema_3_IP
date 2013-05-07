class AddLmdToGrupa < ActiveRecord::Migration
  def change
    add_column :grupe, :zi_id, :string, :limit => 2
    add_column :grupe, :lmd, :string, :limit => 1
  end
end
