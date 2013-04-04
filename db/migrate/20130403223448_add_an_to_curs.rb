class AddAnToCurs < ActiveRecord::Migration
  def change
    add_column :cursuri, :an, :integer
  end
end
